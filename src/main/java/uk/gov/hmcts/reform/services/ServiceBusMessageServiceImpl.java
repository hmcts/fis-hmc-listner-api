package uk.gov.hmcts.reform.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import uk.gov.hmcts.reform.dtos.requests.PrlUpdateServiceRequest;
import uk.gov.hmcts.reform.exceptions.InvalidPrlUpdateRequestException;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class ServiceBusMessageServiceImpl implements ServiceBusMessageService {

    @Autowired
    private PrlUpdateService prlUpdateService;

    private static final Logger LOG = LoggerFactory.getLogger(ServiceBusMessageServiceImpl.class);

    @Override
    public void processMessageFromTopic(List<byte[]> body, AtomicBoolean result) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        PrlUpdateServiceRequest prlUpdateServiceRequest;
        try {
            prlUpdateServiceRequest = mapper.readValue(body.get(0), PrlUpdateServiceRequest.class);
        } catch (Exception e) {
            throw new InvalidPrlUpdateRequestException("Bad Request", HttpStatus.BAD_REQUEST, e);
        }
        String message = mapper.writeValueAsString(prlUpdateServiceRequest);
        LOG.info("Hearing message body: {}", message);
        this.prlUpdateService.updatePrlServiceWithHearing(prlUpdateServiceRequest);
        result.set(Boolean.TRUE);
    }
}
