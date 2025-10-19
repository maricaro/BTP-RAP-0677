@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Interface entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_I_2137 as projection on Zbksppl_r_2137
{
  key BooksupplUUID,
      TravelUUID,
      BookingUUID,
      BookingSupplementID,
      SupplementID,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZBOOKING_I_2137,
      _Product,
      _SupplementText,
      _Travel  : redirected to ZTRAVEL_I_2137
}
