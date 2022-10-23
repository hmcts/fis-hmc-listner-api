package uk.gov.hmcts.reform.services;

import uk.gov.hmcts.reform.dtos.requests.PrlUpdateServiceRequest;
import uk.gov.hmcts.reform.exceptions.PrlUpdateException;

public interface PrlUpdateService {
    void updatePrlServiceWithHearing(PrlUpdateServiceRequest prlUpdateServiceRequest);

    void recover(PrlUpdateException exception, PrlUpdateServiceRequest prlUpdateServiceRequest);
}
