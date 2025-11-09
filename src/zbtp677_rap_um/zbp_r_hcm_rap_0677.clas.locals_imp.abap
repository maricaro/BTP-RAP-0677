CLASS lcl_buffer DEFINITION.

  PUBLIC SECTION.

    CONSTANTS: created TYPE c LENGTH 1 VALUE 'C',
               updated TYPE c LENGTH 1 VALUE 'U',
               deleted TYPE c LENGTH 1 VALUE 'D'.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE zhcm_master_0677 AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES: tt_master TYPE SORTED TABLE OF ty_buffer WITH UNIQUE KEY e_number.

    CLASS-DATA: it_buffer_master TYPE tt_master.

ENDCLASS.

CLASS lhc_HCM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hcm RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR hcm RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE hcm.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE hcm.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE hcm.

    METHODS read FOR READ
      IMPORTING keys FOR READ hcm RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK hcm.

ENDCLASS.

CLASS lhc_HCM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
      SELECT MAX( e_number ) AS e_number
    FROM zhcm_master_0677
    INTO @DATA(lv_e_number).

    GET TIME STAMP FIELD DATA(lv_tsl).

    LOOP AT entities INTO DATA(ls_entities).

      ls_entities-%data-CreaDateTime = lv_tsl.
      ls_entities-%data-CreaUname = cl_abap_context_info=>get_user_technical_name( ).
      ls_entities-%data-ENumber = lv_e_number + 1.

      INSERT VALUE #( flag = lcl_buffer=>created
                      data = VALUE #( e_number       = ls_entities-%data-ENumber
                                      e_name         = ls_entities-%data-EName
                                      e_department   = ls_entities-%data-EDepartment
                                      status         =  ls_entities-%data-Status
                                      job_title      = ls_entities-%data-JobTitle
                                      start_date     = ls_entities-%data-StartDate
                                      end_date       = ls_entities-%data-EndDate
                                      email          = ls_entities-%data-Email
                                      m_number       = ls_entities-%data-MNumber
                                      m_name         = ls_entities-%data-MName
                                      m_department   = ls_entities-%data-MDepartment
                                      crea_date_time = ls_entities-%data-CreaDateTime
                                      crea_uname     = ls_entities-%data-CreaUname ) ) INTO TABLE lcl_buffer=>it_buffer_master.

      IF ls_entities-%cid IS NOT INITIAL.

        INSERT VALUE #( %cid = ls_entities-%cid
                        ENumber = ls_entities-ENumber ) INTO TABLE mapped-hcm.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

      LOOP AT entities INTO DATA(ls_entities).

      GET TIME STAMP FIELD ls_entities-%data-LchgDateTime.
      ls_entities-%data-LchgUname = cl_abap_context_info=>get_user_technical_name( ).

      SELECT SINGLE *
      FROM zhcm_master_0677
      WHERE e_number = @ls_entities-ENumber
      INTO @DATA(ls_ddbb).

      IF sy-subrc = 0.

        INSERT VALUE #( flag = lcl_buffer=>updated
                        data-e_number = ls_entities-ENumber
                        data-e_name = COND #( WHEN ls_entities-%control-EName = if_abap_behv=>mk-on
                                              THEN ls_entities-%data-EName
                                              ELSE ls_ddbb-e_name )
                        data-e_department = COND #( WHEN ls_entities-%control-EDepartment = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-EDepartment
                                         ELSE ls_ddbb-e_department )
                        data-status       = COND #( WHEN ls_entities-%control-Status = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-Status
                                         ELSE ls_ddbb-status )
                        data-job_title    = COND #( WHEN ls_entities-%control-JobTitle = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-JobTitle
                                         ELSE ls_ddbb-job_title )
                        data-start_date   = COND #( WHEN ls_entities-%control-StartDate = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-StartDate
                                         ELSE ls_ddbb-start_date )
                        data-end_date     = COND #( WHEN ls_entities-%control-EndDate = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-EndDate
                                         ELSE ls_ddbb-end_date )
                        data-email        = COND #( WHEN ls_entities-%control-Email = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-Email
                                         ELSE ls_ddbb-email )
                        data-m_number     = COND #( WHEN ls_entities-%control-MNumber = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-MNumber
                                         ELSE ls_ddbb-m_number )
                        data-m_name       = COND #( WHEN ls_entities-%control-MName = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-MName
                                         ELSE ls_ddbb-m_name )
                        data-m_department = COND #( WHEN ls_entities-%control-MDepartment = if_abap_behv=>mk-on
                                         THEN ls_entities-%data-MDepartment
                                         ELSE ls_ddbb-m_department )
                        data-lchg_date_time = ls_entities-%data-LchgDateTime
                        data-lchg_uname = ls_entities-%data-LchgUname ) INTO TABLE lcl_buffer=>it_buffer_master.

        IF ls_entities-ENumber IS NOT INITIAL.

          INSERT VALUE #( %cid = ls_entities-ENumber
                          ENumber = ls_entities-ENumber ) INTO TABLE mapped-hcm.

        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

      LOOP AT keys INTO DATA(ls_keys).

      INSERT VALUE #( flag = lcl_buffer=>deleted
                      data-e_number = ls_keys-ENumber ) INTO TABLE lcl_buffer=>it_buffer_master.

      IF ls_keys-ENumber IS NOT INITIAL.

        INSERT VALUE #( %cid = ls_keys-ENumber
                        ENumber = ls_keys-ENumber ) INTO TABLE mapped-hcm.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_HCM_RAP_0677 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_HCM_RAP_0677 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.


    DATA: lt_data_created TYPE STANDARD TABLE OF zhcm_master_0677,
          lt_data_updated TYPE STANDARD TABLE OF zhcm_master_0677,
          lt_data_deleted TYPE STANDARD TABLE OF zhcm_master_0677.

* Create
    lt_data_created = VALUE #( FOR <row> IN lcl_buffer=>it_buffer_master
                                         WHERE ( flag = lcl_buffer=>created )
                                         ( <row>-data ) ).

    IF lt_data_created IS NOT INITIAL.
      INSERT zhcm_master_0677 FROM TABLE @lt_data_created.
    ENDIF.

* Update
    lt_data_updated = VALUE #( FOR <row> IN lcl_buffer=>it_buffer_master
                                         WHERE ( flag = lcl_buffer=>updated )
                                         ( <row>-data ) ).

    IF lt_data_updated IS NOT INITIAL.
      UPDATE zhcm_master_0677 FROM TABLE @lt_data_updated.
    ENDIF.

* Delete
    lt_data_deleted = VALUE #( FOR <row> IN lcl_buffer=>it_buffer_master
                                         WHERE ( flag = lcl_buffer=>deleted )
                                         ( <row>-data ) ).

    IF lt_data_deleted IS NOT INITIAL.
      DELETE zhcm_master_0677 FROM TABLE @lt_data_deleted.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
