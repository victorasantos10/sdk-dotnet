# MercadoPago SDK module for Payments integration

* [Install](#install)
* [Basic checkout](#basic-checkout)
* [Customized checkout](#custom-checkout)
* [Generic methods](#generic-methods)

<a name="install"></a>
## Install

Copy `bin/mercadopago.dll` to your project desired folder.

<a name="basic-checkout"></a>
## Basic checkout

### Configure your credentials

### ...with your credentials:

* Get your **CLIENT_ID** and **CLIENT_SECRET** in the following address:
    * Argentina: [https://www.mercadopago.com/mla/herramientas/aplicaciones](https://www.mercadopago.com/mla/herramientas/aplicaciones)
    * Brazil: [https://www.mercadopago.com/mlb/ferramentas/aplicacoes](https://www.mercadopago.com/mlb/ferramentas/aplicacoes)
    * México: [https://www.mercadopago.com/mlm/herramientas/aplicaciones](https://www.mercadopago.com/mlm/herramientas/aplicaciones)
    * Venezuela: [https://www.mercadopago.com/mlv/herramientas/aplicaciones](https://www.mercadopago.com/mlv/herramientas/aplicaciones)
    * Colombia: [https://www.mercadopago.com/mco/herramientas/aplicaciones](https://www.mercadopago.com/mco/herramientas/aplicaciones)

```C#
using mercadopago;

MP mp = new MP ("CLIENT_ID", "CLIENT_SECRET");
```

### Preferences

#### Get an existent Checkout preference

```C#
Hashtable preference = mp.getPreference("PREFERENCE_ID");

Response.Write(preference);
```

#### Create a Checkout preference

```C#
Hashtable preference = mp.createPreference("{\"items\":[{\"title\":\"sdk-dotnet\",\"quantity\":1,\"currency_id\":\"ARS\",\"unit_price\":10.5}]}");

Response.Write(preference);
```

#### Update an existent Checkout preference:

```C#
Hashtable preference = mp.updatePreference("PREFERENCE_ID", "{\"items\":[{\"title\":\"sdk-dotnet\",\"quantity\":1,\"currency_id\":\"USD\",\"unit_price\":2}]}");

Response.Write(preference);
```

### Payments/Collections

#### Search for payments

```C#
// Sets the filters you want
Dictionary<String, String> filters = new Dictionary<String, String> ();
    filters.Add("site_id", "MLA"); // Argentina: MLA; Brasil: MLB; Mexico: MLM; Venezuela: MLV; Colombia: MCO
    filters.Add("external_reference", "Bill001");
      
// Search payment data according to filters
Hashtable searchResult = mp.searchPayment (filters);

foreach (Hashtable payment in searchResult.SelectToken ("response.results")) {
    Response.Write(payment["collection"]["id"]);
    Response.Write(payment["collection"]["status"]);
}
```

#### Get payment data

```C#
Hashtable payment_info = mp.getPayment("ID");

Response.Write(payment_info["response"]);
```    

#### Cancel (only for pending payments)

```C#
Hashtable result = mp.cancelPayment("ID");

// Show result
Response.Write(result);
```

#### Refund (only for accredited payments)

```C#
Hashtable result = mp.refundPayment("ID");

// Show result
Response.Write(result);
```

<a name="custom-checkout"></a>
## Customized checkout

### Configure your credentials

* Get your **ACCESS_TOKEN** in the following address:
    * Argentina: [https://www.mercadopago.com/mla/account/credentials](https://www.mercadopago.com/mla/account/credentials)
    * Brazil: [https://www.mercadopago.com/mlb/account/credentials](https://www.mercadopago.com/mlb/account/credentials)
    * Mexico: [https://www.mercadopago.com/mlm/account/credentials](https://www.mercadopago.com/mlm/account/credentials)
    * Venezuela: [https://www.mercadopago.com/mlv/account/credentials](https://www.mercadopago.com/mlv/account/credentials)
    * Colombia: [https://www.mercadopago.com/mco/account/credentials](https://www.mercadopago.com/mco/account/credentials)

```C#
using mercadopago;

MP mp = new MP ("ACCESS_TOKEN");
```

### Create payment

```C#
mp.post ("/v1/payments", paymentData);
```

### Create customer

```C#
mp.post ("/v1/customers", "{'email': 'email@test.com'}");
```

### Get customer

```C#
mp.get ("/v1/customers/CUSTOMER_ID");
```

* View more Custom checkout related APIs in Developers Site
    * Argentina: [https://labs.mercadopago.com.ar/developers](https://labs.mercadopago.com.ar/developers)
    * Brazil: [https://labs.mercadopago.com.br/developers](https://labs.mercadopago.com.br/developers)
    * Mexico: [https://labs.mercadopago.com.mx/developers](https://labs.mercadopago.com.mx/developers)
    * Venezuela: [https://labs.mercadopago.com.ve/developers](https://labs.mercadopago.com.ve/developers)
    * Colombia: [https://labs.mercadopago.com.co/developers](https://labs.mercadopago.com.co/developers)

<a name="generic-methods"></a>
## Generic methods

You can access any other resource from the MercadoPago API using the generic methods:

```C#
// Get a resource, with optional URL params. Also you can disable authentication for public APIs
mp.get ("/resource/uri", [params], [authenticate=true]);

// Create a resource with "data" and optional URL params.
mp.post ("/resource/uri", data, [params]);

// Update a resource with "data" and optional URL params.
mp.put ("/resource/uri", data, [params]);

// Delete a resource with optional URL params.
mp.delete ("/resource/uri", [params]);
```

 For example, if you want to get the Sites list (no params and no authentication):

```C#
Hashtable result = mp.get ("/sites", null, false);

Response.Write(result);
```
