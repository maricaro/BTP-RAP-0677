@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HCM Interface entity'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZI_HCM_RAP_0677
  provider contract transactional_interface
 as projection on ZR_HCM_RAP_0677
{
    key ENumber,
    EName,
    EDepartment,
    Status,
    JobTitle,
    StartDate,
    EndDate,
    Email,
    MNumber,
    MName,
    MDepartment,
    CreaDateTime,
    CreaUname,
    LchgDateTime,
    LchgUname
}
