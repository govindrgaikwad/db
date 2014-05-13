-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: UIFramework
-- Source Schemata: UIFramework
-- Created: Tue May 13 19:28:03 2014
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;;

-- ----------------------------------------------------------------------------
-- Schema UIFramework
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `UIFramework` ;
CREATE SCHEMA IF NOT EXISTS `UIFramework` ;

-- ----------------------------------------------------------------------------
-- Table UIFramework.AccountProductMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`AccountProductMap` (
  `AccountProductMapID` INT NOT NULL AUTO_INCREMENT,
  `FolderID` INT NOT NULL,
  `FolderVersionID` INT NOT NULL,
  `ProductType` VARCHAR(100) NOT NULL,
  `ProductName` VARCHAR(100) NOT NULL,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  PRIMARY KEY (`AccountProductMapID`),
  CONSTRAINT `FK_AccountProductMap_Folder`
    FOREIGN KEY (`FolderID`)
    REFERENCES `UIFramework`.`Folder` (`FolderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_AccountProductMap_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_AccountProductMap_FolderVersion`
    FOREIGN KEY (`FolderVersionID`)
    REFERENCES `UIFramework`.`FolderVersion` (`FolderVersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormInstanceDataMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormInstanceDataMap` (
  `FormInstanceDataMapID` INT NOT NULL AUTO_INCREMENT,
  `FormInstanceID` INT NOT NULL,
  `ObjectInstanceID` INT NOT NULL,
  `FormData` LONGTEXT NULL,
  PRIMARY KEY (`FormInstanceDataMapID`),
  CONSTRAINT `FK_FormInstanceID_FormInstance_FormInstanceID`
    FOREIGN KEY (`FormInstanceID`)
    REFERENCES `UIFramework`.`FormInstance` (`FormInstanceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormInstance
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormInstance` (
  `FormInstanceID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `FolderVersionID` INT NOT NULL,
  `FormDesignID` INT NOT NULL,
  `FormDesignVersionID` INT NOT NULL,
  PRIMARY KEY (`FormInstanceID`),
  CONSTRAINT `FK_FormInstance_FormDesign`
    FOREIGN KEY (`FormDesignID`)
    REFERENCES `UIFramework`.`FormDesign` (`FormID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FormInstance_FormDesignVersion`
    FOREIGN KEY (`FormDesignVersionID`)
    REFERENCES `UIFramework`.`FormDesignVersion` (`FormDesignVersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FormInstance_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FormInstance_FolderVersion`
    FOREIGN KEY (`FolderVersionID`)
    REFERENCES `UIFramework`.`FolderVersion` (`FolderVersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.MarketSegment
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`MarketSegment` (
  `MarketSegmentID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `MarketSegmentName` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(500) NULL,
  PRIMARY KEY (`MarketSegmentID`),
  CONSTRAINT `FK_MarketSegment_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.VersionType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`VersionType` (
  `VersionTypeID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `VersionType` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`VersionTypeID`),
  CONSTRAINT `FK_VersionType_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.Folder
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Folder` (
  `FolderID` INT NOT NULL AUTO_INCREMENT,
  `IsPortfolio` TINYINT(1) NOT NULL,
  `Name` VARCHAR(200) NOT NULL,
  `AccountID` INT NULL,
  `MarketSegmentID` INT NOT NULL,
  `PrimaryContent` VARCHAR(100) NOT NULL,
  `PrimaryContentID` INT NULL,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  PRIMARY KEY (`FolderID`),
  CONSTRAINT `FK_Folder_Account`
    FOREIGN KEY (`AccountID`)
    REFERENCES `UIFramework`.`Account` (`AccountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Folder_MarketSegment`
    FOREIGN KEY (`MarketSegmentID`)
    REFERENCES `UIFramework`.`MarketSegment` (`MarketSegmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Folder_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Folder_User`
    FOREIGN KEY (`PrimaryContentID`)
    REFERENCES `UIFramework`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.WorkFlowState
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`WorkFlowState` (
  `WFStateID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `WFStateName` VARCHAR(100) NOT NULL,
  `Sequence` INT NOT NULL,
  `IsActive` TINYINT(1) NOT NULL DEFAULT 0,
  `WFStateGroupID` INT NOT NULL,
  PRIMARY KEY (`WFStateID`),
  CONSTRAINT `FK_WorkFlowState_WorkFlowStateGroup`
    FOREIGN KEY (`WFStateGroupID`)
    REFERENCES `UIFramework`.`WorkFlowStateGroup` (`WFStateGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkFlowState_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.WorkFlowStateGroup
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`WorkFlowStateGroup` (
  `WFStateGroupID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `WFStateGroupName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`WFStateGroupID`),
  CONSTRAINT `FK_WorkFlowStateGroup_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.ApprovalStatusType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ApprovalStatusType` (
  `ApprovalStatusID` INT NOT NULL AUTO_INCREMENT,
  `ApprovalStatus` VARCHAR(200) NOT NULL,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  PRIMARY KEY (`ApprovalStatusID`),
  CONSTRAINT `FK_ApprovalStatus_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FolderVersionWorkFlowState
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FolderVersionWorkFlowState` (
  `FVWFStateID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `IsActive` TINYINT(1) NOT NULL DEFAULT 0,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `FolderVersionID` INT NOT NULL,
  `WFStateID` INT NOT NULL,
  `ApprovalStatusID` INT NOT NULL,
  `Comments` VARCHAR(500) NULL,
  `UserID` INT NULL,
  PRIMARY KEY (`FVWFStateID`),
  CONSTRAINT `FK_FolderVersionWorkFlowState_UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `UIFramework`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersionWorkFlowState_ApprovalStatus`
    FOREIGN KEY (`ApprovalStatusID`)
    REFERENCES `UIFramework`.`ApprovalStatusType` (`ApprovalStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersionWorkFlowState_WorkFlowState`
    FOREIGN KEY (`WFStateID`)
    REFERENCES `UIFramework`.`WorkFlowState` (`WFStateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersionWorkFlowState_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersionWorkFlowState_FolderVersion`
    FOREIGN KEY (`FolderVersionID`)
    REFERENCES `UIFramework`.`FolderVersion` (`FolderVersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FolderVersion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FolderVersion` (
  `FolderVersionID` INT NOT NULL AUTO_INCREMENT,
  `FolderID` INT NOT NULL,
  `EffectiveDate` DATETIME NOT NULL,
  `WFStateID` INT NOT NULL,
  `FolderVersionNumber` VARCHAR(50) NOT NULL,
  `VersionTypeID` INT NOT NULL,
  `IsActive` TINYINT(1) NOT NULL DEFAULT 0,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  PRIMARY KEY (`FolderVersionID`),
  CONSTRAINT `FK_FolderVersion_Folder`
    FOREIGN KEY (`FolderID`)
    REFERENCES `UIFramework`.`Folder` (`FolderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersion_VersionType`
    FOREIGN KEY (`VersionTypeID`)
    REFERENCES `UIFramework`.`VersionType` (`VersionTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersion_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FolderVersion_WorkFlowState`
    FOREIGN KEY (`WFStateID`)
    REFERENCES `UIFramework`.`WorkFlowState` (`WFStateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.Account
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Account` (
  `AccountID` INT NOT NULL AUTO_INCREMENT,
  `TenantID` INT NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `AddedBy` VARCHAR(20) NOT NULL,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `AccountName` VARCHAR(200) NOT NULL,
  `IsActive` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccountID`),
  CONSTRAINT `FK_Account_Tenant`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Account_Tenant1`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.StringDataValue
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`StringDataValue` (
  `ValueID` INT NOT NULL AUTO_INCREMENT,
  `ObjVerID` INT NOT NULL,
  `Value` LONGTEXT NOT NULL,
  `ObjInstanceID` INT NOT NULL,
  `ParentObjInstanceID` INT NULL,
  `RowIDInfo` INT NULL,
  PRIMARY KEY (`ValueID`),
  CONSTRAINT `Fk_StringDataValue1`
    FOREIGN KEY (`ObjVerID`)
    REFERENCES `UIFramework`.`ObjectVersionAttribXref` (`ObjVerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.DateDataValue
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DateDataValue` (
  `ValueID` INT NOT NULL AUTO_INCREMENT,
  `ObjVerID` INT NOT NULL,
  `Value` DATETIME NOT NULL,
  `ObjInstanceID` INT NOT NULL,
  `ParentObjInstanceID` INT NULL,
  `RootInstanceID` INT NOT NULL,
  `RowIDInfo` INT NULL,
  PRIMARY KEY (`ValueID`),
  CONSTRAINT `Fk_DateDataValue1`
    FOREIGN KEY (`ObjVerID`)
    REFERENCES `UIFramework`.`ObjectVersionAttribXref` (`ObjVerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.NumericDataValue
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`NumericDataValue` (
  `ValueID` INT NOT NULL AUTO_INCREMENT,
  `ObjVerID` INT NOT NULL,
  `Value` DECIMAL(10,10) NOT NULL,
  `ObjInstanceID` INT NOT NULL,
  `ParentObjInstanceID` INT NULL,
  `RowIDInfo` INT NULL,
  PRIMARY KEY (`ValueID`),
  CONSTRAINT `FkDataValue1`
    FOREIGN KEY (`ObjVerID`)
    REFERENCES `UIFramework`.`ObjectVersionAttribXref` (`ObjVerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT NOT NULL,
  `diagram_id` INT NOT NULL AUTO_INCREMENT,
  `version` INT NULL,
  `definition` LONGBLOB NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ELMAH_Error
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ELMAH_Error` (
  `ErrorId` VARCHAR(64) UNIQUE NOT NULL,
  `Application` VARCHAR(120) NOT NULL,
  `Host` VARCHAR(100) NOT NULL,
  `Type` VARCHAR(200) NOT NULL,
  `Source` VARCHAR(120) NOT NULL,
  `Message` VARCHAR(1000) NOT NULL,
  `User` VARCHAR(100) NOT NULL,
  `StatusCode` INT NOT NULL,
  `TimeUtc` DATETIME NOT NULL,
  `Sequence` INT NOT NULL,
  `AllXml` LONGTEXT NOT NULL,
  PRIMARY KEY (`ErrorId`),
  INDEX `IX_ELMAH_Error_App_Time_Seq` (`Application` ASC, `TimeUtc` DESC, `Sequence` DESC));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ObjectRelation
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ObjectRelation` (
  `RelationID` INT NOT NULL AUTO_INCREMENT,
  `RelatedObjectID` INT NULL,
  `RelationName` VARCHAR(200) NULL,
  `RelationNameCamelcase` VARCHAR(200) NULL,
  `Cardinality` CHAR(1) NULL,
  PRIMARY KEY (`RelationID`),
  CONSTRAINT `FK_ObjectRelation_ObjectDefinition`
    FOREIGN KEY (`RelatedObjectID`)
    REFERENCES `UIFramework`.`ObjectDefinition` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.Attribute
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Attribute` (
  `AttrID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `NameCamelcase` VARCHAR(200) NULL,
  `AttrType` VARCHAR(100) NULL,
  `Cardinality` CHAR(1) NULL,
  `Length` INT NULL,
  `Precision` INT NULL,
  `EditRegex` VARCHAR(180) NULL,
  `Formatter` VARCHAR(180) NULL,
  `Synthetic` TINYINT(1) NULL,
  `DefaultValue` VARCHAR(510) NULL,
  PRIMARY KEY (`AttrID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ObjectDefinition
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ObjectDefinition` (
  `OID` INT NOT NULL AUTO_INCREMENT,
  `ObjectName` VARCHAR(200) NOT NULL,
  `TenantID` INT NOT NULL,
  `Locked` TINYINT(1) NULL,
  PRIMARY KEY (`OID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ObjectVersion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ObjectVersion` (
  `VersionID` INT NOT NULL AUTO_INCREMENT,
  `VersionName` VARCHAR(110) NOT NULL,
  `EffectiveFrom` DATETIME NULL,
  `EffectiveTo` DATETIME NULL,
  PRIMARY KEY (`VersionID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ObjectVersionAttribXref
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ObjectVersionAttribXref` (
  `ObjVerID` INT NOT NULL AUTO_INCREMENT,
  `VersionID` INT NOT NULL,
  `OID` INT NOT NULL,
  `AttrID` INT NOT NULL,
  PRIMARY KEY (`ObjVerID`),
  CONSTRAINT `Fk_ObjectVersion_Xref1`
    FOREIGN KEY (`VersionID`)
    REFERENCES `UIFramework`.`ObjectVersion` (`VersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_ObjectVersionXref3`
    FOREIGN KEY (`AttrID`)
    REFERENCES `UIFramework`.`Attribute` (`AttrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_ObjectVersion_Xref2`
    FOREIGN KEY (`OID`)
    REFERENCES `UIFramework`.`ObjectDefinition` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.ObjectTree
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ObjectTree` (
  `TreeID` INT NOT NULL AUTO_INCREMENT,
  `ParentOID` INT NULL,
  `RootOID` INT NOT NULL,
  `RelationID` INT NULL,
  `VersionID` INT NOT NULL,
  PRIMARY KEY (`TreeID`),
  CONSTRAINT `FK_ObjectTree_ObjectRelation`
    FOREIGN KEY (`RelationID`)
    REFERENCES `UIFramework`.`ObjectRelation` (`RelationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Object_Tree4`
    FOREIGN KEY (`VersionID`)
    REFERENCES `UIFramework`.`ObjectVersion` (`VersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Parent_ObjectTree`
    FOREIGN KEY (`ParentOID`)
    REFERENCES `UIFramework`.`ObjectDefinition` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Root_ObjectTree`
    FOREIGN KEY (`RootOID`)
    REFERENCES `UIFramework`.`ObjectDefinition` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.RelationKeys
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`RelationKeys` (
  `RelationKeyID` INT NOT NULL AUTO_INCREMENT,
  `RelationID` INT NOT NULL,
  `LHSAttrID` INT NOT NULL,
  `RHSAttrID` INT NOT NULL,
  PRIMARY KEY (`RelationKeyID`),
  CONSTRAINT `FK_RelationKeys_ObjectRelation`
    FOREIGN KEY (`RelationID`)
    REFERENCES `UIFramework`.`ObjectRelation` (`RelationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RelationKeys_LHSAttribute`
    FOREIGN KEY (`LHSAttrID`)
    REFERENCES `UIFramework`.`Attribute` (`AttrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RelationKeys_RHSAttribute`
    FOREIGN KEY (`RHSAttrID`)
    REFERENCES `UIFramework`.`Attribute` (`AttrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.User
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(200) NULL,
  `EmailConfirmed` TINYINT(1) NULL,
  `PasswordHash` VARCHAR(200) NULL,
  `SecurityStamp` VARCHAR(200) NULL,
  `PhoneNumber` VARCHAR(50) NULL,
  `PhoneNumberConfirmed` TINYINT(1) NULL,
  `TwoFactorEnabled` TINYINT(1) NULL,
  `LockoutEndDateUtc` DATETIME NULL,
  `LockoutEnabled` TINYINT(1) NULL,
  `AccessFailedCount` INT NULL,
  `TenantID` INT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UK_User_UserName` (`UserName` ASC),
  CONSTRAINT `FK_User_TenantID`
    FOREIGN KEY (`TenantID`)
    REFERENCES `UIFramework`.`Tenant` (`TenantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.UserActivity
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`UserActivity` (
  `EventID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(10) NULL,
  `Event` VARCHAR(20) NULL,
  `TimeUtc` DATETIME NULL,
  `UserName` VARCHAR(100) NULL,
  `Host` VARCHAR(100) NULL,
  `RequestUrl` VARCHAR(100) NULL,
  `AppDomain` VARCHAR(100) NULL,
  `UserAgent` VARCHAR(40) NULL,
  `Priority` INT NULL,
  `Severity` VARCHAR(40) NULL,
  `TenantID` INT NULL,
  `Message` VARCHAR(1000) NULL,
  PRIMARY KEY (`EventID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.Tenant
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Tenant` (
  `TenantID` INT NOT NULL AUTO_INCREMENT,
  `TenantName` VARCHAR(20) NOT NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `CreateBy` VARCHAR(20) NOT NULL,
  `UpdateBy` VARCHAR(20) NULL,
  `CreateDt` DATETIME NOT NULL,
  `UpdateDt` DATETIME NULL,
  PRIMARY KEY (`TenantID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.Rule
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Rule` (
  `RuleID` INT NOT NULL AUTO_INCREMENT,
  `RuleName` LONGTEXT NOT NULL,
  `RuleDescription` VARCHAR(1000) NULL,
  `RuleTargetTypeID` INT NOT NULL,
  `ResultSuccess` VARCHAR(1000) NULL,
  `ResultFailure` VARCHAR(1000) NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`RuleID`),
  CONSTRAINT `FK_Rule_RuleTargetType`
    FOREIGN KEY (`RuleTargetTypeID`)
    REFERENCES `UIFramework`.`RuleTargetType` (`RuleTargetTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.Validator
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Validator` (
  `ValidatorID` INT NOT NULL AUTO_INCREMENT,
  `UIElementID` INT NOT NULL,
  `IsRequired` TINYINT(1) NULL,
  `Regex` VARCHAR(200) NULL,
  `IsLibraryRegex` TINYINT(1) NULL,
  `LibraryRegexID` INT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `Message` VARCHAR(500) NULL,
  PRIMARY KEY (`ValidatorID`),
  CONSTRAINT `FK_Validator_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Validator_RegexLibrary`
    FOREIGN KEY (`LibraryRegexID`)
    REFERENCES `UIFramework`.`RegexLibrary` (`LibraryRegexID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.SectionUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`SectionUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 8,
  `ChildCount` INT NOT NULL,
  `LayoutTypeID` INT NOT NULL,
  `DataSourceID` INT NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_SectionUIElement_DataSource`
    FOREIGN KEY (`DataSourceID`)
    REFERENCES `UIFramework`.`DataSource` (`DataSourceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SectionUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SectionUIElement_LayoutType`
    FOREIGN KEY (`LayoutTypeID`)
    REFERENCES `UIFramework`.`LayoutType` (`LayoutTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SectionUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.TabUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`TabUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 7,
  `ChildCount` INT NOT NULL,
  `LayoutTypeID` INT NOT NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_TabUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TabUIElement_LayoutType`
    FOREIGN KEY (`LayoutTypeID`)
    REFERENCES `UIFramework`.`LayoutType` (`LayoutTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TabUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.DataSource
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DataSource` (
  `DataSourceID` INT NOT NULL AUTO_INCREMENT,
  `DataSourceName` VARCHAR(200) NULL,
  `DataSourceDescription` VARCHAR(1000) NULL,
  `Type` VARCHAR(30) NOT NULL,
  `AddedBy` VARCHAR(40) NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(40) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`DataSourceID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.RepeaterUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`RepeaterUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL,
  `LayoutTypeID` INT NOT NULL,
  `ChildCount` INT NULL,
  `DataSourceID` INT NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_RepeaterUIElement_DataSource`
    FOREIGN KEY (`DataSourceID`)
    REFERENCES `UIFramework`.`DataSource` (`DataSourceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RepeaterUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RepeaterUIElement_LayoutType`
    FOREIGN KEY (`LayoutTypeID`)
    REFERENCES `UIFramework`.`LayoutType` (`LayoutTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.RadioButtonUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`RadioButtonUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 1,
  `OptionLabel` VARCHAR(40) NULL,
  `DefaultValue` TINYINT(1) NULL,
  `IsYesNo` TINYINT(1) NOT NULL DEFAULT 1,
  `OptionLabelNo` VARCHAR(200) NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_RadioButtonUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RadioButtonUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormVersionObjectVersionMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormVersionObjectVersionMap` (
  `FormVersionObjectVersionMap` INT NOT NULL AUTO_INCREMENT,
  `FormDesignVersionID` INT NOT NULL,
  `ObjectVersionID` INT NOT NULL,
  PRIMARY KEY (`FormVersionObjectVersionMap`),
  CONSTRAINT `FK_FormDesignVersionID_FormDesignVersion_FormDesignVersionID`
    FOREIGN KEY (`FormDesignVersionID`)
    REFERENCES `UIFramework`.`FormDesignVersion` (`FormDesignVersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ObjectVersionID_ObjectVersion_ObjectVersionID`
    FOREIGN KEY (`ObjectVersionID`)
    REFERENCES `UIFramework`.`ObjectVersion` (`VersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.PropertyRuleMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`PropertyRuleMap` (
  `PropertyRuleMapID` INT NOT NULL AUTO_INCREMENT,
  `RuleID` INT NOT NULL,
  `UIElementID` INT NOT NULL,
  `TargetPropertyID` INT NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsCustomRule` TINYINT(1) NULL,
  PRIMARY KEY (`PropertyRuleMapID`),
  CONSTRAINT `FK_PropertyRuleMap_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PropertyRuleMap_Rule`
    FOREIGN KEY (`RuleID`)
    REFERENCES `UIFramework`.`Rule` (`RuleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PropertyRuleMap_TargetProperty`
    FOREIGN KEY (`TargetPropertyID`)
    REFERENCES `UIFramework`.`TargetProperty` (`TargetPropertyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.TextBoxUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`TextBoxUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 3,
  `IsMultiline` TINYINT(1) NULL,
  `DefaultValue` VARCHAR(4000) NULL,
  `MaxLength` INT NOT NULL DEFAULT 50,
  `IsLabel` TINYINT(1) NOT NULL DEFAULT 0,
  `SpellCheck` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_TextBoxUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TextBoxUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormDesignVersionUIElementMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormDesignVersionUIElementMap` (
  `FormDesignVersionUIElementMapID` INT NOT NULL AUTO_INCREMENT,
  `FormDesignVersionID` INT NOT NULL,
  `UIElementID` INT NOT NULL,
  `EffectiveDate` DATETIME NULL,
  `EffectiveDateOfRemoval` DATETIME NULL,
  PRIMARY KEY (`FormDesignVersionUIElementMapID`),
  CONSTRAINT `FK_MasterTemplateVersionUIElementMap_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.UIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`UIElement` (
  `UIElementID` INT NOT NULL AUTO_INCREMENT,
  `UIElementName` VARCHAR(100) NULL,
  `Label` VARCHAR(500) NULL,
  `ParentUIElementID` INT NULL,
  `IsContainer` TINYINT(1) NOT NULL,
  `Enabled` TINYINT(1) NULL,
  `Visible` TINYINT(1) NULL,
  `Sequence` INT NOT NULL,
  `RequiresValidation` TINYINT(1) NOT NULL DEFAULT 1,
  `HelpText` VARCHAR(2000) NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `FormID` INT NOT NULL,
  `UIElementDataTypeID` INT NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `HasCustomRule` TINYINT(1) NULL DEFAULT 0,
  `CustomRule` VARCHAR(5000) NULL,
  `GeneratedName` VARCHAR(200) NULL,
  `DataSourceElementDisplayModeID` INT NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_UIElement_DataSourceElementDisplayMode`
    FOREIGN KEY (`DataSourceElementDisplayModeID`)
    REFERENCES `UIFramework`.`DataSourceElementDisplayMode` (`DataSourceElementDisplayModeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UIElement_FormID`
    FOREIGN KEY (`FormID`)
    REFERENCES `UIFramework`.`FormDesign` (`FormID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UIElement_UIElement`
    FOREIGN KEY (`ParentUIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UIElement_UIElementDataType`
    FOREIGN KEY (`UIElementDataTypeID`)
    REFERENCES `UIFramework`.`ApplicationDataType` (`ApplicationDataTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.CheckBoxUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`CheckBoxUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 2,
  `OptionLabel` VARCHAR(40) NULL,
  `DefaultValue` TINYINT(1) NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_CheckBoxUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CheckBoxUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.CalendarUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`CalendarUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 6,
  `MinDate` DATETIME NULL,
  `MaxDate` DATETIME NULL,
  `DefaultDate` DATETIME NULL,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_CalendarUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CalendarUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.Expression
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Expression` (
  `ExpressionID` INT NOT NULL AUTO_INCREMENT,
  `LeftOperand` LONGTEXT NULL,
  `RightOperand` VARCHAR(500) NULL,
  `OperatorTypeID` INT NOT NULL,
  `LogicalOperatorTypeID` INT NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `RuleID` INT NOT NULL,
  PRIMARY KEY (`ExpressionID`),
  CONSTRAINT `FK_Expression_LogicalOperatorType`
    FOREIGN KEY (`LogicalOperatorTypeID`)
    REFERENCES `UIFramework`.`LogicalOperatorType` (`LogicalOperatorTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Expression_OperatorType`
    FOREIGN KEY (`OperatorTypeID`)
    REFERENCES `UIFramework`.`OperatorType` (`OperatorTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Expression_Rule`
    FOREIGN KEY (`RuleID`)
    REFERENCES `UIFramework`.`Rule` (`RuleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.DropDownUIElement
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DropDownUIElement` (
  `UIElementID` INT NOT NULL,
  `UIElementTypeID` INT NOT NULL DEFAULT 5,
  `SelectedValue` VARCHAR(50) NULL,
  `IsMultiSelect` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`UIElementID`),
  CONSTRAINT `FK_DropDownUIElement_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DropDownUIElement_UIElementType`
    FOREIGN KEY (`UIElementTypeID`)
    REFERENCES `UIFramework`.`UIElementType` (`UIElementTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.RegexLibrary
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`RegexLibrary` (
  `LibraryRegexID` INT NOT NULL AUTO_INCREMENT,
  `LibraryRegexName` VARCHAR(50) NOT NULL,
  `RegexValue` VARCHAR(200) NOT NULL,
  `Description` VARCHAR(200) NOT NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`LibraryRegexID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.DropDownElementItem
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DropDownElementItem` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `UIElementID` INT NOT NULL,
  `Value` VARCHAR(200) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `DisplayText` VARCHAR(200) NOT NULL,
  `Sequence` INT NULL,
  PRIMARY KEY (`ItemID`),
  CONSTRAINT `FK_DropDownElementItem_DropDownUIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`DropDownUIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.TargetProperty
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`TargetProperty` (
  `TargetPropertyID` INT NOT NULL AUTO_INCREMENT,
  `TargetPropertyName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`TargetPropertyID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.Status
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`Status` (
  `StatusID` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(20) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`StatusID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.RuleTargetType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`RuleTargetType` (
  `RuleTargetTypeID` INT NOT NULL AUTO_INCREMENT,
  `RuleTargetTypeCode` VARCHAR(10) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `DisplayText` VARCHAR(20) NULL,
  `Description` VARCHAR(200) NULL,
  PRIMARY KEY (`RuleTargetTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.UIElementType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`UIElementType` (
  `UIElementTypeID` INT NOT NULL AUTO_INCREMENT,
  `UIElementTypeCode` VARCHAR(10) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `DisplayText` VARCHAR(20) NULL,
  `Description` VARCHAR(200) NULL,
  PRIMARY KEY (`UIElementTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.ApplicationDataType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`ApplicationDataType` (
  `ApplicationDataTypeID` INT NOT NULL AUTO_INCREMENT,
  `ApplicationDataTypeName` VARCHAR(20) NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `DisplayText` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ApplicationDataTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.LogicalOperatorType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`LogicalOperatorType` (
  `LogicalOperatorTypeID` INT NOT NULL AUTO_INCREMENT,
  `LogicalOperatorTypeCode` VARCHAR(10) NOT NULL,
  `DisplayText` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`LogicalOperatorTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.DataSourceMapping
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DataSourceMapping` (
  `DataSourceMappingID` INT NOT NULL AUTO_INCREMENT,
  `UIElementID` INT NOT NULL,
  `DataSourceID` INT NOT NULL,
  `MappedUIElementID` INT NOT NULL,
  `IsPrimary` TINYINT(1) NOT NULL DEFAULT 0,
  `DataSourceElementDisplayModeID` INT NULL,
  PRIMARY KEY (`DataSourceMappingID`),
  CONSTRAINT `FK_DataSourceMapping_DataSource`
    FOREIGN KEY (`DataSourceID`)
    REFERENCES `UIFramework`.`DataSource` (`DataSourceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataSourceMapping_UIElement`
    FOREIGN KEY (`UIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataSourceMapping_UIElement1`
    FOREIGN KEY (`MappedUIElementID`)
    REFERENCES `UIFramework`.`UIElement` (`UIElementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataSourceMapping_DataSourceElementDisplayMode`
    FOREIGN KEY (`DataSourceElementDisplayModeID`)
    REFERENCES `UIFramework`.`DataSourceElementDisplayMode` (`DataSourceElementDisplayModeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.LayoutType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`LayoutType` (
  `LayoutTypeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `LayoutTypeCode` VARCHAR(50) NOT NULL,
  `DisplayText` VARCHAR(50) NOT NULL,
  `ClassName` VARCHAR(50) NULL,
  `ColumnCount` INT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`LayoutTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.KeyProductUIElementMap
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`KeyProductUIElementMap` (
  `KeyProductUIElementMapID` INT NOT NULL AUTO_INCREMENT,
  `UIelementID` INT NOT NULL,
  `ParentUIelementID` INT NOT NULL,
  `MasterTemplateID` INT NOT NULL,
  PRIMARY KEY (`KeyProductUIElementMapID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormDesign
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormDesign` (
  `FormID` INT NOT NULL AUTO_INCREMENT,
  `FormName` VARCHAR(100) NOT NULL,
  `DisplayText` VARCHAR(100) NULL,
  `IsActive` TINYINT(1) NOT NULL,
  `Abbreviation` VARCHAR(12) NULL,
  `TenantID` INT NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`FormID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormDesignGroup
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormDesignGroup` (
  `FormDesignGroupID` INT NOT NULL AUTO_INCREMENT,
  `GroupName` VARCHAR(100) NULL,
  `TenantID` INT NOT NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`FormDesignGroupID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.OperatorType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`OperatorType` (
  `OperatorTypeID` INT NOT NULL AUTO_INCREMENT,
  `OperatorTypeCode` VARCHAR(10) NOT NULL,
  `DisplayText` VARCHAR(30) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `AddedBy` VARCHAR(20) NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(20) NULL,
  `UpdatedDate` DATETIME NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`OperatorTypeID`));

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormDesignGroupMapping
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormDesignGroupMapping` (
  `FormDesignGroupMappingID` INT NOT NULL AUTO_INCREMENT,
  `FormDesignGroupID` INT NOT NULL,
  `FormID` INT NOT NULL,
  `Sequence` INT NULL,
  `AllowMultipleInstance` TINYINT(1) NULL,
  `AccessibleToRoles` LONGTEXT NULL,
  PRIMARY KEY (`FormDesignGroupMappingID`),
  CONSTRAINT `FK_FormDesignGroupMapping_FormDesignGroup`
    FOREIGN KEY (`FormDesignGroupID`)
    REFERENCES `UIFramework`.`FormDesignGroup` (`FormDesignGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FormDesignGroupMapping_FormDesignGroupMapping`
    FOREIGN KEY (`FormID`)
    REFERENCES `UIFramework`.`FormDesign` (`FormID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.FormDesignVersion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`FormDesignVersion` (
  `FormDesignVersionID` INT NOT NULL AUTO_INCREMENT,
  `FormDesignID` INT NULL,
  `TenantID` INT NULL,
  `VersionNumber` VARCHAR(30) NULL,
  `EffectiveDate` DATETIME NULL,
  `FormDesignVersionData` LONGTEXT NULL,
  `StatusID` INT NOT NULL,
  `AddedBy` VARCHAR(40) NOT NULL,
  `AddedDate` DATETIME NOT NULL,
  `UpdatedBy` VARCHAR(40) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`FormDesignVersionID`),
  CONSTRAINT `FK_FormDesignVersion_FormDesign`
    FOREIGN KEY (`FormDesignID`)
    REFERENCES `UIFramework`.`FormDesign` (`FormID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FormDesignVersion_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `UIFramework`.`Status` (`StatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table UIFramework.DataSourceElementDisplayMode
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `UIFramework`.`DataSourceElementDisplayMode` (
  `DataSourceElementDisplayModeID` INT NOT NULL AUTO_INCREMENT,
  `DisplayMode` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DataSourceElementDisplayModeID`));

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_upgraddiagrams
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_upgraddiagrams
-- 	AS
-- 	BEGIN
-- 		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
-- 			return 0;
-- 	
-- 		CREATE TABLE dbo.sysdiagrams
-- 		(
-- 			name sysname NOT NULL,
-- 			principal_id int NOT NULL,	-- we may change it to varbinary(85)
-- 			diagram_id int PRIMARY KEY IDENTITY,
-- 			version int,
-- 	
-- 			definition varbinary(max)
-- 			CONSTRAINT UK_principal_name UNIQUE
-- 			(
-- 				principal_id,
-- 				name
-- 			)
-- 		);
-- 
-- 
-- 		/* Add this if we need to have some form of extended properties for diagrams */
-- 		/*
-- 		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
-- 		BEGIN
-- 			CREATE TABLE dbo.sysdiagram_properties
-- 			(
-- 				diagram_id int,
-- 				name sysname,
-- 				value varbinary(max) NOT NULL
-- 			)
-- 		END
-- 		*/
-- 
-- 		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
-- 		begin
-- 			insert into dbo.sysdiagrams
-- 			(
-- 				[name],
-- 				[principal_id],
-- 				[version],
-- 				[definition]
-- 			)
-- 			select	 
-- 				convert(sysname, dgnm.[uvalue]),
-- 				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
-- 				0,							-- zero for old format, dgdef.[version],
-- 				dgdef.[lvalue]
-- 			from dbo.[dtproperties] dgnm
-- 				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
-- 				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
-- 				
-- 			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
-- 			return 2;
-- 		end
-- 		return 1;
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_helpdiagrams
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_helpdiagrams
-- 	(
-- 		@diagramname sysname = NULL,
-- 		@owner_id int = NULL
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		DECLARE @user sysname
-- 		DECLARE @dboLogin bit
-- 		EXECUTE AS CALLER;
-- 			SET @user = USER_NAME();
-- 			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
-- 		REVERT;
-- 		SELECT
-- 			[Database] = DB_NAME(),
-- 			[Name] = name,
-- 			[ID] = diagram_id,
-- 			[Owner] = USER_NAME(principal_id),
-- 			[OwnerID] = principal_id
-- 		FROM
-- 			sysdiagrams
-- 		WHERE
-- 			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
-- 			(@diagramname IS NULL OR name = @diagramname) AND
-- 			(@owner_id IS NULL OR principal_id = @owner_id)
-- 		ORDER BY
-- 			4, 5, 1
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_helpdiagramdefinition
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_helpdiagramdefinition
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null 		
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 
-- 		declare @theId 		int
-- 		declare @IsDbo 		int
-- 		declare @DiagId		int
-- 		declare @UIDFound	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert; 
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 
-- 		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_creatediagram
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_creatediagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id		int	= null, 	
-- 		@version 		int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId int
-- 		declare @retval int
-- 		declare @IsDbo	int
-- 		declare @userName sysname
-- 		if(@version is null or @diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID(); 
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		revert; 
-- 		
-- 		if @owner_id is null
-- 		begin
-- 			select @owner_id = @theId;
-- 		end
-- 		else
-- 		begin
-- 			if @theId <> @owner_id
-- 			begin
-- 				if @IsDbo = 0
-- 				begin
-- 					RAISERROR (N'E_INVALIDARG', 16, 1);
-- 					return -1
-- 				end
-- 				select @theId = @owner_id
-- 			end
-- 		end
-- 		-- next 2 line only for test, will be removed after define name unique
-- 		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end
-- 	
-- 		insert into dbo.sysdiagrams(name, principal_id , version, definition)
-- 				VALUES(@diagramname, @theId, @version, @definition) ;
-- 		
-- 		select @retval = @@IDENTITY 
-- 		return @retval
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_renamediagram
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_renamediagram
-- 	(
-- 		@diagramname 		sysname,
-- 		@owner_id		int	= null,
-- 		@new_diagramname	sysname
-- 	
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @DiagIdTarg		int
-- 		declare @u_name			sysname
-- 		if((@diagramname is null) or (@new_diagramname is null))
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT;
-- 	
-- 		select @u_name = USER_NAME(@owner_id)
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
-- 		--	return 0;
-- 	
-- 		if(@u_name is null)
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
-- 		else
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
-- 	
-- 		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end		
-- 	
-- 		if(@u_name is null)
-- 			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
-- 		else
-- 			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_alterdiagram
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_alterdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null,
-- 		@version 	int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId 			int
-- 		declare @retval 		int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @ShouldChangeUID	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid ARG', 16, 1)
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();	 
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert;
-- 	
-- 		select @ShouldChangeUID = 0
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 	
-- 		if(@IsDbo <> 0)
-- 		begin
-- 			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
-- 			begin
-- 				select @ShouldChangeUID = 1 ;
-- 			end
-- 		end
-- 
-- 		-- update dds data			
-- 		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;
-- 
-- 		-- change owner
-- 		if(@ShouldChangeUID = 1)
-- 			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;
-- 
-- 		-- update dds version
-- 		if(@version is not null)
-- 			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;
-- 
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.sp_dropdiagram
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_dropdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT; 
-- 		
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		delete from dbo.sysdiagrams where diagram_id = @DiagId;
-- 	
-- 		return 0;
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.fn_diagramobjects
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- 	CREATE  OR REPLACE FUNCTION dbo.fn_diagramobjects() 
-- 	RETURNS int
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		declare @id_upgraddiagrams		int
-- 		declare @id_sysdiagrams			int
-- 		declare @id_helpdiagrams		int
-- 		declare @id_helpdiagramdefinition	int
-- 		declare @id_creatediagram	int
-- 		declare @id_renamediagram	int
-- 		declare @id_alterdiagram 	int 
-- 		declare @id_dropdiagram		int
-- 		declare @InstalledObjects	int
-- 
-- 		select @InstalledObjects = 0
-- 
-- 		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
-- 			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
-- 			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
-- 			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
-- 			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
-- 			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
-- 			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
-- 			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')
-- 
-- 		if @id_upgraddiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 1
-- 		if @id_sysdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 2
-- 		if @id_helpdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 4
-- 		if @id_helpdiagramdefinition is not null
-- 			select @InstalledObjects = @InstalledObjects + 8
-- 		if @id_creatediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 16
-- 		if @id_renamediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 32
-- 		if @id_alterdiagram  is not null
-- 			select @InstalledObjects = @InstalledObjects + 64
-- 		if @id_dropdiagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 128
-- 		
-- 		return @InstalledObjects 
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View UIFramework.ELMAH_GetErrorXml
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[ELMAH_GetErrorXml]
-- (
--     @Application NVARCHAR(60),
--     @ErrorId UNIQUEIDENTIFIER
-- )
-- AS
-- 
--     SET NOCOUNT ON
-- 
--     SELECT 
--         [AllXml]
--     FROM 
--         [ELMAH_Error]
--     WHERE
--         [ErrorId] = @ErrorId
--     AND
--         [Application] = @Application
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View UIFramework.ELMAH_GetErrorsXml
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
-- (
--     @Application NVARCHAR(60),
--     @PageIndex INT = 0,
--     @PageSize INT = 15,
--     @TotalCount INT OUTPUT
-- )
-- AS 
-- 
--     SET NOCOUNT ON
-- 
--     DECLARE @FirstTimeUTC DATETIME
--     DECLARE @FirstSequence INT
--     DECLARE @StartRow INT
--     DECLARE @StartRowIndex INT
-- 
--     SELECT 
--         @TotalCount = COUNT(1) 
--     FROM 
--         [ELMAH_Error]
--     WHERE 
--         [Application] = @Application
-- 
--     -- Get the ID of the first error for the requested page
-- 
--     SET @StartRowIndex = @PageIndex * @PageSize + 1
-- 
--     IF @StartRowIndex <= @TotalCount
--     BEGIN
-- 
--         SET ROWCOUNT @StartRowIndex
-- 
--         SELECT  
--             @FirstTimeUTC = [TimeUtc],
--             @FirstSequence = [Sequence]
--         FROM 
--             [ELMAH_Error]
--         WHERE   
--             [Application] = @Application
--         ORDER BY 
--             [TimeUtc] DESC, 
--             [Sequence] DESC
-- 
--     END
--     ELSE
--     BEGIN
-- 
--         SET @PageSize = 0
-- 
--     END
-- 
--     -- Now set the row count to the requested page size and get
--     -- all records below it for the pertaining application.
-- 
--     SET ROWCOUNT @PageSize
-- 
--     SELECT 
--         errorId     = [ErrorId], 
--         application = [Application],
--         host        = [Host], 
--         type        = [Type],
--         source      = [Source],
--         message     = [Message],
--         [user]      = [User],
--         statusCode  = [StatusCode], 
--         time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
--     FROM 
--         [ELMAH_Error] error
--     WHERE
--         [Application] = @Application
--     AND
--         [TimeUtc] <= @FirstTimeUTC
--     AND 
--         [Sequence] <= @FirstSequence
--     ORDER BY
--         [TimeUtc] DESC, 
--         [Sequence] DESC
--     FOR
--         XML AUTO
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View UIFramework.ELMAH_LogError
-- ----------------------------------------------------------------------------
-- USE `UIFramework`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[ELMAH_LogError]
-- (
--     @ErrorId UNIQUEIDENTIFIER,
--     @Application NVARCHAR(60),
--     @Host NVARCHAR(30),
--     @Type NVARCHAR(100),
--     @Source NVARCHAR(60),
--     @Message NVARCHAR(500),
--     @User NVARCHAR(50),
--     @AllXml NTEXT,
--     @StatusCode INT,
--     @TimeUtc DATETIME
-- )
-- AS
-- 
--     SET NOCOUNT ON
-- 
--     INSERT
--     INTO
--         [ELMAH_Error]
--         (
--             [ErrorId],
--             [Application],
--             [Host],
--             [Type],
--             [Source],
--             [Message],
--             [User],
--             [AllXml],
--             [StatusCode],
--             [TimeUtc]
--         )
--     VALUES
--         (
--             @ErrorId,
--             @Application,
--             @Host,
--             @Type,
--             @Source,
--             @Message,
--             @User,
--             @AllXml,
--             @StatusCode,
--             @TimeUtc
--         )
-- 
-- ;

-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_upgraddiagrams
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_upgraddiagrams
-- 	AS
-- 	BEGIN
-- 		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
-- 			return 0;
-- 	
-- 		CREATE TABLE dbo.sysdiagrams
-- 		(
-- 			name sysname NOT NULL,
-- 			principal_id int NOT NULL,	-- we may change it to varbinary(85)
-- 			diagram_id int PRIMARY KEY IDENTITY,
-- 			version int,
-- 	
-- 			definition varbinary(max)
-- 			CONSTRAINT UK_principal_name UNIQUE
-- 			(
-- 				principal_id,
-- 				name
-- 			)
-- 		);
-- 
-- 
-- 		/* Add this if we need to have some form of extended properties for diagrams */
-- 		/*
-- 		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
-- 		BEGIN
-- 			CREATE TABLE dbo.sysdiagram_properties
-- 			(
-- 				diagram_id int,
-- 				name sysname,
-- 				value varbinary(max) NOT NULL
-- 			)
-- 		END
-- 		*/
-- 
-- 		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
-- 		begin
-- 			insert into dbo.sysdiagrams
-- 			(
-- 				[name],
-- 				[principal_id],
-- 				[version],
-- 				[definition]
-- 			)
-- 			select	 
-- 				convert(sysname, dgnm.[uvalue]),
-- 				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
-- 				0,							-- zero for old format, dgdef.[version],
-- 				dgdef.[lvalue]
-- 			from dbo.[dtproperties] dgnm
-- 				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
-- 				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
-- 				
-- 			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
-- 			return 2;
-- 		end
-- 		return 1;
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_helpdiagrams
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_helpdiagrams
-- 	(
-- 		@diagramname sysname = NULL,
-- 		@owner_id int = NULL
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		DECLARE @user sysname
-- 		DECLARE @dboLogin bit
-- 		EXECUTE AS CALLER;
-- 			SET @user = USER_NAME();
-- 			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
-- 		REVERT;
-- 		SELECT
-- 			[Database] = DB_NAME(),
-- 			[Name] = name,
-- 			[ID] = diagram_id,
-- 			[Owner] = USER_NAME(principal_id),
-- 			[OwnerID] = principal_id
-- 		FROM
-- 			sysdiagrams
-- 		WHERE
-- 			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
-- 			(@diagramname IS NULL OR name = @diagramname) AND
-- 			(@owner_id IS NULL OR principal_id = @owner_id)
-- 		ORDER BY
-- 			4, 5, 1
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_helpdiagramdefinition
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_helpdiagramdefinition
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null 		
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 
-- 		declare @theId 		int
-- 		declare @IsDbo 		int
-- 		declare @DiagId		int
-- 		declare @UIDFound	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert; 
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 
-- 		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_creatediagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_creatediagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id		int	= null, 	
-- 		@version 		int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId int
-- 		declare @retval int
-- 		declare @IsDbo	int
-- 		declare @userName sysname
-- 		if(@version is null or @diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID(); 
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		revert; 
-- 		
-- 		if @owner_id is null
-- 		begin
-- 			select @owner_id = @theId;
-- 		end
-- 		else
-- 		begin
-- 			if @theId <> @owner_id
-- 			begin
-- 				if @IsDbo = 0
-- 				begin
-- 					RAISERROR (N'E_INVALIDARG', 16, 1);
-- 					return -1
-- 				end
-- 				select @theId = @owner_id
-- 			end
-- 		end
-- 		-- next 2 line only for test, will be removed after define name unique
-- 		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end
-- 	
-- 		insert into dbo.sysdiagrams(name, principal_id , version, definition)
-- 				VALUES(@diagramname, @theId, @version, @definition) ;
-- 		
-- 		select @retval = @@IDENTITY 
-- 		return @retval
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_renamediagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_renamediagram
-- 	(
-- 		@diagramname 		sysname,
-- 		@owner_id		int	= null,
-- 		@new_diagramname	sysname
-- 	
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @DiagIdTarg		int
-- 		declare @u_name			sysname
-- 		if((@diagramname is null) or (@new_diagramname is null))
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT;
-- 	
-- 		select @u_name = USER_NAME(@owner_id)
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
-- 		--	return 0;
-- 	
-- 		if(@u_name is null)
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
-- 		else
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
-- 	
-- 		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end		
-- 	
-- 		if(@u_name is null)
-- 			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
-- 		else
-- 			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_alterdiagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_alterdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null,
-- 		@version 	int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId 			int
-- 		declare @retval 		int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @ShouldChangeUID	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid ARG', 16, 1)
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();	 
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert;
-- 	
-- 		select @ShouldChangeUID = 0
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 	
-- 		if(@IsDbo <> 0)
-- 		begin
-- 			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
-- 			begin
-- 				select @ShouldChangeUID = 1 ;
-- 			end
-- 		end
-- 
-- 		-- update dds data			
-- 		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;
-- 
-- 		-- change owner
-- 		if(@ShouldChangeUID = 1)
-- 			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;
-- 
-- 		-- update dds version
-- 		if(@version is not null)
-- 			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;
-- 
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.sp_dropdiagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_dropdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT; 
-- 		
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		delete from dbo.sysdiagrams where diagram_id = @DiagId;
-- 	
-- 		return 0;
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.ELMAH_GetErrorXml
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- CREATE PROCEDURE [dbo].[ELMAH_GetErrorXml]
-- (
--     @Application NVARCHAR(60),
--     @ErrorId UNIQUEIDENTIFIER
-- )
-- AS
-- 
--     SET NOCOUNT ON
-- 
--     SELECT 
--         [AllXml]
--     FROM 
--         [ELMAH_Error]
--     WHERE
--         [ErrorId] = @ErrorId
--     AND
--         [Application] = @Application
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.ELMAH_GetErrorsXml
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
-- (
--     @Application NVARCHAR(60),
--     @PageIndex INT = 0,
--     @PageSize INT = 15,
--     @TotalCount INT OUTPUT
-- )
-- AS 
-- 
--     SET NOCOUNT ON
-- 
--     DECLARE @FirstTimeUTC DATETIME
--     DECLARE @FirstSequence INT
--     DECLARE @StartRow INT
--     DECLARE @StartRowIndex INT
-- 
--     SELECT 
--         @TotalCount = COUNT(1) 
--     FROM 
--         [ELMAH_Error]
--     WHERE 
--         [Application] = @Application
-- 
--     -- Get the ID of the first error for the requested page
-- 
--     SET @StartRowIndex = @PageIndex * @PageSize + 1
-- 
--     IF @StartRowIndex <= @TotalCount
--     BEGIN
-- 
--         SET ROWCOUNT @StartRowIndex
-- 
--         SELECT  
--             @FirstTimeUTC = [TimeUtc],
--             @FirstSequence = [Sequence]
--         FROM 
--             [ELMAH_Error]
--         WHERE   
--             [Application] = @Application
--         ORDER BY 
--             [TimeUtc] DESC, 
--             [Sequence] DESC
-- 
--     END
--     ELSE
--     BEGIN
-- 
--         SET @PageSize = 0
-- 
--     END
-- 
--     -- Now set the row count to the requested page size and get
--     -- all records below it for the pertaining application.
-- 
--     SET ROWCOUNT @PageSize
-- 
--     SELECT 
--         errorId     = [ErrorId], 
--         application = [Application],
--         host        = [Host], 
--         type        = [Type],
--         source      = [Source],
--         message     = [Message],
--         [user]      = [User],
--         statusCode  = [StatusCode], 
--         time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
--     FROM 
--         [ELMAH_Error] error
--     WHERE
--         [Application] = @Application
--     AND
--         [TimeUtc] <= @FirstTimeUTC
--     AND 
--         [Sequence] <= @FirstSequence
--     ORDER BY
--         [TimeUtc] DESC, 
--         [Sequence] DESC
--     FOR
--         XML AUTO
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.ELMAH_LogError
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- CREATE PROCEDURE [dbo].[ELMAH_LogError]
-- (
--     @ErrorId UNIQUEIDENTIFIER,
--     @Application NVARCHAR(60),
--     @Host NVARCHAR(30),
--     @Type NVARCHAR(100),
--     @Source NVARCHAR(60),
--     @Message NVARCHAR(500),
--     @User NVARCHAR(50),
--     @AllXml NTEXT,
--     @StatusCode INT,
--     @TimeUtc DATETIME
-- )
-- AS
-- 
--     SET NOCOUNT ON
-- 
--     INSERT
--     INTO
--         [ELMAH_Error]
--         (
--             [ErrorId],
--             [Application],
--             [Host],
--             [Type],
--             [Source],
--             [Message],
--             [User],
--             [AllXml],
--             [StatusCode],
--             [TimeUtc]
--         )
--     VALUES
--         (
--             @ErrorId,
--             @Application,
--             @Host,
--             @Type,
--             @Source,
--             @Message,
--             @User,
--             @AllXml,
--             @StatusCode,
--             @TimeUtc
--         )
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine UIFramework.fn_diagramobjects
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `UIFramework`$$
-- 
-- 	CREATE FUNCTION dbo.fn_diagramobjects() 
-- 	RETURNS int
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		declare @id_upgraddiagrams		int
-- 		declare @id_sysdiagrams			int
-- 		declare @id_helpdiagrams		int
-- 		declare @id_helpdiagramdefinition	int
-- 		declare @id_creatediagram	int
-- 		declare @id_renamediagram	int
-- 		declare @id_alterdiagram 	int 
-- 		declare @id_dropdiagram		int
-- 		declare @InstalledObjects	int
-- 
-- 		select @InstalledObjects = 0
-- 
-- 		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
-- 			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
-- 			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
-- 			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
-- 			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
-- 			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
-- 			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
-- 			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')
-- 
-- 		if @id_upgraddiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 1
-- 		if @id_sysdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 2
-- 		if @id_helpdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 4
-- 		if @id_helpdiagramdefinition is not null
-- 			select @InstalledObjects = @InstalledObjects + 8
-- 		if @id_creatediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 16
-- 		if @id_renamediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 32
-- 		if @id_alterdiagram  is not null
-- 			select @InstalledObjects = @InstalledObjects + 64
-- 		if @id_dropdiagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 128
-- 		
-- 		return @InstalledObjects 
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- SET FOREIGN_KEY_CHECKS = 1;;
