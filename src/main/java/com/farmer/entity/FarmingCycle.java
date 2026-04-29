package com.farmer.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class FarmingCycle {
    private Long id;
    private Long userId;
    private String businessType;
    private Long itemId;
    private String itemName;
    private String cycleName;
    private BigDecimal scaleValue;
    private String scaleUnit;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expectedEndDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date actualEndDate;
    private String status;
    private Integer isPublic;
    private String description;
    private String ownerName;
    private String creatorRoleType;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getBusinessType() { return businessType; }
    public void setBusinessType(String businessType) { this.businessType = businessType; }
    public Long getItemId() { return itemId; }
    public void setItemId(Long itemId) { this.itemId = itemId; }
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public String getCycleName() { return cycleName; }
    public void setCycleName(String cycleName) { this.cycleName = cycleName; }
    public BigDecimal getScaleValue() { return scaleValue; }
    public void setScaleValue(BigDecimal scaleValue) { this.scaleValue = scaleValue; }
    public String getScaleUnit() { return scaleUnit; }
    public void setScaleUnit(String scaleUnit) { this.scaleUnit = scaleUnit; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getExpectedEndDate() { return expectedEndDate; }
    public void setExpectedEndDate(Date expectedEndDate) { this.expectedEndDate = expectedEndDate; }
    public Date getActualEndDate() { return actualEndDate; }
    public void setActualEndDate(Date actualEndDate) { this.actualEndDate = actualEndDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Integer getIsPublic() { return isPublic; }
    public void setIsPublic(Integer isPublic) { this.isPublic = isPublic; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public String getCreatorRoleType() { return creatorRoleType; }
    public void setCreatorRoleType(String creatorRoleType) { this.creatorRoleType = creatorRoleType; }
}
