-- FUNCTION: public.get_customers_with_pagination_json(integer, integer, integer, character varying, character varying, character varying, character varying, text, character varying, character varying, character varying, character varying, character varying, character varying, character varying, boolean, boolean, character varying)

-- DROP FUNCTION IF EXISTS public.get_customers_with_pagination_json(integer, integer, integer, character varying, character varying, character varying, character varying, text, character varying, character varying, character varying, character varying, character varying, character varying, character varying, boolean, boolean, character varying);

CREATE OR REPLACE FUNCTION public.get_customers_with_pagination_json(
	in_page integer,
	in_limit integer,
	in_customer_id integer,
	in_customer_name character varying,
	in_contact_name character varying,
	in_address_line_1 character varying,
	in_address_line_2 character varying,
	in_email_address text,
	in_city character varying,
	in_state character varying,
	in_zip character varying,
	in_country character varying,
	in_phone1 character varying,
	in_phone2 character varying,
	in_fax character varying,
	in_is_primary boolean,
	in_is_active boolean,
	in_added_by character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    sql_query text;
    result_json json;
BEGIN
    sql_query := 'SELECT json_agg(row_to_json(t)) FROM (SELECT * FROM public.customers WHERE 1=1';

    IF in_customer_id IS NOT NULL THEN
        sql_query := sql_query || ' AND customer_id = ' || in_customer_id;
    END IF;

    IF in_customer_name IS NOT NULL THEN
        sql_query := sql_query || ' AND customer_name ILIKE ''%' || in_customer_name || '%''';
    END IF;

    IF in_contact_name IS NOT NULL THEN
        sql_query := sql_query || ' AND contact_name ILIKE ''%' || in_contact_name || '%''';
    END IF;

    IF in_address_line_1 IS NOT NULL THEN
        sql_query := sql_query || ' AND address_line_1 ILIKE ''%' || in_address_line_1 || '%''';
    END IF;

    IF in_address_line_2 IS NOT NULL THEN
        sql_query := sql_query || ' AND address_line_2 ILIKE ''%' || in_address_line_2 || '%''';
    END IF;

    IF in_email_address IS NOT NULL THEN
        sql_query := sql_query || ' AND email_address ILIKE ''%' || in_email_address || '%''';
    END IF;

    IF in_city IS NOT NULL THEN
        sql_query := sql_query || ' AND city ILIKE ''%' || in_city || '%''';
    END IF;

    IF in_state IS NOT NULL THEN
        sql_query := sql_query || ' AND state ILIKE ''%' || in_state || '%''';
    END IF;

    IF in_zip IS NOT NULL THEN
        sql_query := sql_query || ' AND zip ILIKE ''%' || in_zip || '%''';
    END IF;

    IF in_country IS NOT NULL THEN
        sql_query := sql_query || ' AND country ILIKE ''%' || in_country || '%''';
    END IF;

    IF in_phone1 IS NOT NULL THEN
        sql_query := sql_query || ' AND phone1 ILIKE ''%' || in_phone1 || '%''';
    END IF;

    IF in_phone2 IS NOT NULL THEN
        sql_query := sql_query || ' AND phone2 ILIKE ''%' || in_phone2 || '%''';
    END IF;

    IF in_fax IS NOT NULL THEN
        sql_query := sql_query || ' AND fax ILIKE ''%' || in_fax || '%''';
    END IF;

    IF in_is_primary IS NOT NULL THEN
        sql_query := sql_query || ' AND is_primary = ' || in_is_primary;
    END IF;

    IF in_is_active IS NOT NULL THEN
        sql_query := sql_query || ' AND is_active = ' || in_is_active;
    END IF;

    IF in_added_by IS NOT NULL THEN
        sql_query := sql_query || ' AND added_by ILIKE ''%' || in_added_by || '%''';
    END IF;

    sql_query := sql_query || ' ORDER BY customer_id OFFSET ' || (in_page - 1) * in_limit || ' LIMIT ' || in_limit || ') t';

    EXECUTE sql_query INTO result_json;

    RETURN result_json;
END;
$BODY$;

ALTER FUNCTION public.get_customers_with_pagination_json(integer, integer, integer, character varying, character varying, character varying, character varying, text, character varying, character varying, character varying, character varying, character varying, character varying, character varying, boolean, boolean, character varying)
    OWNER TO postgres;


select * from customers;
SELECT * FROM public.get_customers_with_pagination_json(1, 5, NULL, 'a', 'Mike Johnson', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
