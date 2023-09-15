from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .dboperations import get_customers_with_pagination



@api_view(['GET'])
def get_customers(request):
    page = int(request.data.get('page',1))
    limit = int(request.data.get('limit',10))
    customer_id = request.data.get('customer_id')
    customer_name = request.data.get('customer_name')
    contact_name = request.data.get('contact_name')
    address_line_1 = request.data.get('address_line_1')
    address_line_2 = request.data.get('address_line_2')
    email_address = request.data.get('email_address')
    city = request.data.get('city')
    state = request.data.get('state')
    zip_code = request.data.get('zip')
    country = request.data.get('country')
    phone1 = request.data.get('phone1')
    phone2 = request.data.get('phone2')
    fax = request.data.get('fax')
    is_primary = request.data.get('is_primary')
    is_active = request.data.get('is_active')
    added_by = request.data.get('added_by')

    results = get_customers_with_pagination(
        page, limit, customer_id, customer_name, contact_name,
        address_line_1, address_line_2, email_address, city, state,
        zip_code, country, phone1, phone2, fax, is_primary, is_active,
        added_by
    )

    return Response(results)











# @api_view(['GET'])
# def get_customers(request):
#     if request.method == 'GET':
#         in_page = request.GET.get('Page',1)
#         in_limit = request.GET.get('Limit',5)
#         in_customer_id = request.GET.get('Customer ID')
#         in_customer_name= request.GET.get('Customer Name')
#         in_contact_name= request.GET.get('Contact Name')
#         in_address_line_1= request.GET.get('Address 1')
#         in_address_line_2= request.GET.get('Address 2')
#         in_email_address= request.GET.get('Email Address')
#         in_city= request.GET.get('City')
#         in_state= request.GET.get('State')
#         in_zip= request.GET.get('Zipcode')
#         in_country= request.GET.get('Country')
#         in_phone1= request.GET.get('Phone Number')
#         in_phone2= request.GET.get('Alternate Phone Number')
#         in_fax= request.GET.get('Fax. Number')
#         in_is_primary= request.GET.get('Is Primary')
#         in_is_active= request.GET.get('Is Active')
#         in_added_by= request.GET.get('Added By')

#         results= dbop_get_customers_with_filters(in_page,in_limit,in_customer_id,in_customer_name,in_contact_name,in_address_line_1,in_address_line_2,in_email_address,in_city,in_state,in_zip,in_country,in_phone1,in_phone2,in_fax,in_is_primary,in_is_active,in_added_by)
#         return Response(results)