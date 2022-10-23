package uk.gov.hmcts.reform.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import uk.gov.hmcts.reform.dtos.requests.PrlUpdateServiceRequest;
import uk.gov.hmcts.reform.exceptions.InvalidPrlUpdateRequestException;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

@ExtendWith(MockitoExtension.class)
class ServiceBusMessageServiceTest {

    @Mock
    private AtomicBoolean result;

    @Mock
    private PrlUpdateService prlUpdateService;

    @InjectMocks
    private ServiceBusMessageServiceImpl serviceBusMessageService;

    ObjectMapper objectMapper = new ObjectMapper();

    @Test
    void processMessageFromTopicTest() throws IOException {
        PrlUpdateServiceRequest prlUpdateServiceRequest = PrlUpdateServiceRequest.PrlUpdateServiceRequest()
                                                            .hmctsServiceCode("hmctsServiceCode")
                                                            .caseRef("caseRef")
                                                            .hearingID("hearingID")
                                                            .hearingUpdate("hearingUpdate")
                                                            .build();
        byte[] objAsBytes = objectMapper.writeValueAsString(prlUpdateServiceRequest).getBytes();
        List<byte[]> body = Arrays.asList(objAsBytes);
        Mockito.doNothing().when(prlUpdateService).updatePrlServiceWithHearing(prlUpdateServiceRequest);
        serviceBusMessageService.processMessageFromTopic(body,result);
        Mockito.verify(prlUpdateService).updatePrlServiceWithHearing(prlUpdateServiceRequest);
    }

    @Test
    void processMessageFromTopicWithInvalidRequestBodyShouldThrowInvalidCpoUpdateRequestException() throws IOException {
        PrlUpdateServiceRequest prlUpdateServiceRequest = PrlUpdateServiceRequest.PrlUpdateServiceRequest()
            .hmctsServiceCode("hmctsServiceCode")
            .caseRef("caseRef")
            .build();
        byte[] objAsBytes = prlUpdateServiceRequest.toString().getBytes();
        List<byte[]> body = Arrays.asList(objAsBytes);
        InvalidPrlUpdateRequestException exception = assertThrows(InvalidPrlUpdateRequestException.class,
            () -> serviceBusMessageService.processMessageFromTopic(body, result)
        );
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus(),"Status should be Bad Request");
        assertEquals("Bad Request", exception.getServer(),"Exception should be Bad Request");
    }
}
