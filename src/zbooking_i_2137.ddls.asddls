@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Interface entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBOOKING_I_2137 as projection on ZBOOKING_R_2137
{
    key BookingUUID,
        TravelUUID,
        BookingID,
        BookingDate,
        CustomerID,
        AirlineID,
        ConnectionID,
        FlightDate,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        FlightPrice,
        CurrencyCode,
        BookingStatus,
        
     //Local ETag Field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true        
        LocalLastChangedAt,
        
        /* Associations */
        _BookingStatus,
        _BookingSupplement : redirected to composition child ZBKSPPL_I_2137,
        _Carrier,
        _Connection,
        _Customer,
        //Redirecciona al padre para tomar sus propiedades
        _Travel : redirected to parent ZTRAVEL_I_2137
}
