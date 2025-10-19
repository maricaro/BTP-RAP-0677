@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZTRAVEL_C_2137
 provider contract transactional_query
 as projection on ZTRAVEL_R_2137
{
  key TravelUUID,

      @Search.defaultSearchElement: true
      TravelID,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency_StdVH',
                                                     element: 'AgencyID' },
                                           useForValidation: true }]
      AgencyID,
      _Agency.Name       as AgencyName,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer_StdVH',
                                                     element: 'CustomerID'},
                                           useForValidation: true }]
      CustomerID,
      _Customer.LastName as CustomerName,

      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      
      // Virtual element
       @Semantics.amount.currencyCode: 'CurrencyCode'
       @EndUserText.label: 'VAT Included'
       @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIR_ELEM_SADL_2137'
       virtual PriceWithVAT : /dmo/total_price,     
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH',
                                                     element: 'Currency' },
                                            useForValidation: true }]      
      CurrencyCode,
      
      Description,
      
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH',
                                                     element: 'OverallStatus'},
                                           useForValidation: true }]      
      OverallStatus,
      _OverallStatus._Text.Text as OverallStatusText : localized,      

      LocalCreatedBy,
      
      LocalCreatedAt,
      
      LocalLastChangedBy,
      
      LocalLastChangedAt,
      
      LastChangedAt,

      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZBOOKING_C_2137,
      _Currency,
      _Customer,
      _OverallStatus
}
