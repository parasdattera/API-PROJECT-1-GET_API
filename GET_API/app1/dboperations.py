from django.db import connection


def get_customers_with_pagination(in_page, in_limit, in_customer_id, in_customer_name, in_contact_name,
                in_address_line_1, in_address_line_2, in_email_address, in_city, in_state,
                in_zip, in_country, in_phone1, in_phone2, in_fax, in_is_primary, in_is_active,
                in_added_by):
    # Create a cursor
    with connection.cursor() as cursor:
        # Call the PostgreSQL UDF
        cursor.callproc(
            'public.get_customers_with_pagination_json',
            [
                in_page, in_limit, in_customer_id, in_customer_name, in_contact_name,
                in_address_line_1, in_address_line_2, in_email_address, in_city, in_state,
                in_zip, in_country, in_phone1, in_phone2, in_fax, in_is_primary, in_is_active,
                in_added_by
            ]
        )
        # Get the result
        result = cursor.fetchall()

    return result






# def dbop_get_customers_with_filters(in_page,in_limit,in_customer_id=None,in_customer_name=None,in_contact_name=None,in_address_line_1=None,in_address_line_2=None,in_email_address=None,in_city=None,in_state=None,in_zip=None,in_country=None,in_phone1=None,in_phone2=None,in_fax=None,in_is_primary=None,in_is_active=None,in_added_by=None):
#     with connection.cursor() as cursor:
#         cursor.callproc(
#             'get_customers_with_pagination_json',[in_page,in_limit,in_customer_id,in_customer_name,in_contact_name,in_address_line_1,in_address_line_2,in_email_address,in_city,in_state,in_zip,in_country,in_phone1,in_phone2,in_fax,in_is_primary,in_is_active,in_added_by]
#         )
#         result = cursor.fetchone()
#     return result[0] if result else []