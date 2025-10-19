CLASS zcl_data_travel2137 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_travel2137 IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

DATA: lt_travel   TYPE TABLE OF ztbtravel_2137_a,
      lt_booking  TYPE TABLE OF ztbbooking2137_a,
      lt_book_sup TYPE TABLE OF ztbbksppl_2137_a.

SELECT travel_id,
       agency_id,
       customer_id,
       begin_date,
       end_date,
       booking_fee,
       total_price,
       currency_code,
       description,
       status AS overall_status,
       createdby AS local_created_by,
       createdat AS local_created_at
      " lastchangedby AS local_last_changed_a
       FROM /dmo/travel INTO CORRESPONDING FIELDS OF TABLE @lt_travel UP TO 15 ROWS.

SELECT * FROM /dmo/booking INTO CORRESPONDING FIELDS OF TABLE @lt_booking.

SELECT * FROM /dmo/book_suppl INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup.

DELETE FROM: ztbtravel_2137_a, ztbbooking2137_a, ztbbksppl_2137_a.

INSERT: ztbtravel_2137_a FROM TABLE @lt_travel, ztbbooking2137_a FROM TABLE @lt_booking, ztbbksppl_2137_a FROM TABLE @lt_book_sup.
out->write( sy-dbcnt ). out->write( 'DONE!' ).

ENDMETHOD.

ENDCLASS.
