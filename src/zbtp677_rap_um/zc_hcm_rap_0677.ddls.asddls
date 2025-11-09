@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HCM Consumption entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define root view entity ZC_HCM_RAP_0677 
  provider contract transactional_query
as projection on ZR_HCM_RAP_0677
{
      @ObjectModel.text.element: [ 'EName' ]
  key ENumber,
      EName,
      EDepartment,
      Status,
      JobTitle,
      StartDate,
      EndDate,
      Email,
      @ObjectModel.text.element: [ 'MName' ]
      MNumber,
      MName,
      MDepartment,
      @Semantics.systemDateTime.createdAt: true
      CreaDateTime,
      @Semantics.user.createdBy: true
      CreaUname,
      @Semantics.systemDateTime.lastChangedAt: true
      LchgDateTime,
      @Semantics.user.lastChangedBy: true
      LchgUname
}
