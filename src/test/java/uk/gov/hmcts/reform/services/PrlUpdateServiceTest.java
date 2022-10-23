package uk.gov.hmcts.reform.services;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import uk.gov.hmcts.reform.authorisation.generators.AuthTokenGenerator;
import uk.gov.hmcts.reform.dtos.requests.PrlUpdateServiceRequest;
import uk.gov.hmcts.reform.dtos.responses.IdamTokenResponse;
import uk.gov.hmcts.reform.exceptions.MaxTryExceededException;
import uk.gov.hmcts.reform.exceptions.PrlUpdateException;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;

@ExtendWith(MockitoExtension.class)
class PrlUpdateServiceTest {

    @Mock
    private IdamService idamService;

    @Mock
    private AuthTokenGenerator authTokenGenerator;

    @Mock
    private RestTemplate restTemplatePrl;

    @InjectMocks
    private final PrlUpdateServiceImpl prlUpdateService = new PrlUpdateServiceImpl();

    IdamTokenResponse idamTokenResponse = IdamTokenResponse.idamFullNameRetrivalResponseWith()
        .refreshToken("refresh-token")
        .idToken("id-token")
        .accessToken("access-token")
        .expiresIn("10")
        .scope("openid profile roles")
        .tokenType("type")
        .build();
    private static final String MOCK_S2S_TOKEN = "mock-serv-auth-token";
    private static final String S2S_SERVER = "S2S";

    @BeforeEach
    public void setUp() {
        ReflectionTestUtils.setField(prlUpdateService, "prlBaseUrl", "http://localhost:3000");
        ReflectionTestUtils.setField(prlUpdateService, "prlPath", "/prlpath");
    }

    @Test
    void updatePrlServiceWithHearingShouldUpdatePrlService() {
        Mockito.when(restTemplatePrl.exchange(anyString(),eq(HttpMethod.POST),Mockito.any(),eq(
            String.class))).thenReturn(ResponseEntity.status(HttpStatus.OK).build());
        Mockito.when(idamService.getSecurityTokens()).thenReturn(idamTokenResponse);
        Mockito.when(authTokenGenerator.generate()).thenReturn(MOCK_S2S_TOKEN);
        prlUpdateService.updatePrlServiceWithHearing(getPrlUpdateServiceRequest());
        Mockito.verify(authTokenGenerator).generate();
        Mockito.verify(idamService).getSecurityTokens();
        HttpEntity entity = getHttpEntity();
        Mockito.verify(restTemplatePrl).exchange("http://localhost:3000/prlpath",HttpMethod.POST,entity,String.class);
    }


    @Test
    void updatePrlServiceWithHearingWhenServiceUnavailableShouldThrowPrlUpdateSection() {

        Mockito.when(restTemplatePrl.exchange(anyString(),eq(HttpMethod.POST),Mockito.any(),eq(
            String.class))).thenThrow(new HttpClientErrorException(HttpStatus.SERVICE_UNAVAILABLE));
        Mockito.when(idamService.getSecurityTokens()).thenReturn(idamTokenResponse);
        Mockito.when(authTokenGenerator.generate()).thenReturn(MOCK_S2S_TOKEN);
        PrlUpdateException exception = assertThrows(
            PrlUpdateException.class,
            () -> prlUpdateService.updatePrlServiceWithHearing(getPrlUpdateServiceRequest()));
        assertEquals("PRL",exception.getServer(),"Server should be PRL");
    }

    @Test
    void updatePrlServiceWithPaymentWhenResourceNotAccesibleShouldThrowPrlUpdateSection() {
        Mockito.when(restTemplatePrl.exchange(anyString(),eq(HttpMethod.POST),Mockito.any(),eq(
            String.class))).thenThrow(new ResourceAccessException(""));
        Mockito.when(idamService.getSecurityTokens()).thenReturn(idamTokenResponse);
        Mockito.when(authTokenGenerator.generate()).thenReturn(MOCK_S2S_TOKEN);
        PrlUpdateException exception = assertThrows(
            PrlUpdateException.class,
            () -> prlUpdateService.updatePrlServiceWithHearing(getPrlUpdateServiceRequest()));
        assertEquals("PRL",exception.getServer(),"Server should be PRL");
        assertEquals(HttpStatus.SERVICE_UNAVAILABLE,exception.getStatus(),"Status should be service unavailble");
    }

    @Test
    void updatePrlServiceWithHearingWhenServiceAuthGeneratorIsDownShouldThrowPrlUpdateSection() {
        Mockito.when(idamService.getSecurityTokens()).thenReturn(idamTokenResponse);
        Mockito.when(authTokenGenerator.generate())
            .thenThrow(new HttpServerErrorException(HttpStatus.SERVICE_UNAVAILABLE));
        PrlUpdateException exception = assertThrows(
            PrlUpdateException.class,
            () -> prlUpdateService.updatePrlServiceWithHearing(getPrlUpdateServiceRequest()));
        assertEquals(S2S_SERVER,exception.getServer(),"Server should be S2S");
        assertEquals(HttpStatus.SERVICE_UNAVAILABLE,exception.getStatus(),"Status should be service unavailable");
    }

    @Test
    void updatePrlServiceWithHearingWhenServiceAuthGeneratorNotAccesibleShouldThrowPrlUpdateSection() {
        Mockito.when(idamService.getSecurityTokens()).thenReturn(idamTokenResponse);
        Mockito.when(authTokenGenerator.generate()).thenThrow(new ResourceAccessException(""));
        PrlUpdateException exception = assertThrows(
            PrlUpdateException.class,
            () -> prlUpdateService.updatePrlServiceWithHearing(getPrlUpdateServiceRequest()));
        assertEquals(S2S_SERVER,exception.getServer(),"Server should be S2S");
        assertEquals(HttpStatus.SERVICE_UNAVAILABLE,exception.getStatus(),"Status should be service unavailble");
    }

    @Test
    void whenRetryIsExceedsMaxTryExceededExceptionIsThrown() {
        MaxTryExceededException exception = assertThrows(MaxTryExceededException.class,
            () -> prlUpdateService.recover(
                 new PrlUpdateException(S2S_SERVER, HttpStatus.SERVICE_UNAVAILABLE,
                                        mock(Throwable.class)), getPrlUpdateServiceRequest()));
        assertEquals(S2S_SERVER,exception.getServer(),"Server should be S2S");
        assertEquals(HttpStatus.SERVICE_UNAVAILABLE,exception.getStatus(),"Status should be service unavailable");
    }

    private HttpEntity<PrlUpdateServiceRequest> getHttpEntity() {
        MultiValueMap<String, String> inputHeaders = new LinkedMultiValueMap<>();
        inputHeaders.put("Content-Type", Arrays.asList("application/json"));
        inputHeaders.put("Authorization", Arrays.asList("Bearer " + idamTokenResponse.getAccessToken()));
        inputHeaders.put("ServiceAuthorization", Arrays.asList(MOCK_S2S_TOKEN));
        PrlUpdateServiceRequest prlUpdateServiceRequest = getPrlUpdateServiceRequest();
        return new HttpEntity<PrlUpdateServiceRequest>(prlUpdateServiceRequest,inputHeaders);
    }

    private PrlUpdateServiceRequest getPrlUpdateServiceRequest() {
        return PrlUpdateServiceRequest.PrlUpdateServiceRequest()
            .hmctsServiceCode("hmctsServiceCode")
            .caseRef("caseRef")
            .hearingID("hearingID")
            .hearingUpdate("hearingUpdate")
            .build();
    }

}
