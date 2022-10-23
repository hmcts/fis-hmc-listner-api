package uk.gov.hmcts.reform.dtos.requests;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Builder;
import lombok.Data;


@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
@Builder(builderMethodName = "PrlUpdateServiceRequest")
@Data
public class PrlUpdateServiceRequest {

    private String hmctsServiceCode;

    private String caseRef;

    private String hearingID;

    private String hearingUpdate;

    public PrlUpdateServiceRequest(@JsonProperty(value = "hmctsServiceCode", required = true) String hmctsServiceCode,
                                   @JsonProperty(value = "caseRef", required = true) String caseRef,
                                   @JsonProperty(value = "hearingID", required = true) String hearingID,
                                   @JsonProperty(value = "hearingUpdate", required = true)
                                       String hearingUpdate) {
        this.hmctsServiceCode = hmctsServiceCode;
        this.caseRef = caseRef;
        this.hearingID = hearingID;
        this.hearingUpdate = hearingUpdate;
    }
}


