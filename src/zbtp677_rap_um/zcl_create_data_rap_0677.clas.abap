CLASS zcl_create_data_rap_0677 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_data_rap_0677 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lv_current_timestamp TYPE timestamp.
    GET TIME STAMP FIELD lv_current_timestamp.

    DELETE FROM zhcm_master_0677.

    MODIFY zhcm_master_0677 FROM @( VALUE #( e_number =  '00000001'
                                     e_name         = 'Lorena Perez'
                                     e_department    = '00000105'
                                     status         = 'I'
                                     job_title      = '00000305'
                                     start_date     = '20250101'
                                     end_date       = ''
                                     email          = 'l.perez@logali.com'
                                     m_number       = '00000103'
                                     m_name         = 'Alicia Best'
                                     m_department    = '00000203'
                                     crea_date_time = lv_current_timestamp
                                     crea_uname     = sy-uname
                                     lchg_date_time = lv_current_timestamp
                                     lchg_uname      = sy-uname ) ).

    IF sy-subrc = 0.
      out->write( 'Done' ).
    ENDIF.

  ENDMETHOD.


ENDCLASS.
