<%@ Page Language="C#" %>
<!doctype html>
<html>
    <head>
        <title>Search payments from an e-mail in January</title>
    </head>
    <body>
		<%-- Include Mercadopago library --%>
		<%@ Import Namespace="mercadopago" %>
		<%@ Import Namespace="System.Collections" %>
		<%@ Import Namespace="System.Collections.Generic" %>
        <%
        /**
         * MercadoPago SDK
         * Search payments from an e-mail in January
         * @date 2012/03/29
         * @author hcasatti
         */
        
        // Create an instance with your MercadoPago credentials (CLIENT_ID and CLIENT_SECRET): 
        // Argentina: https://www.mercadopago.com/mla/herramientas/aplicaciones 
        // Brasil: https://www.mercadopago.com/mlb/ferramentas/aplicacoes
        MP mp = new MP ("CLIENT_ID", "CLIENT_SECRET");
      
        // Sets the filters you want
		Dictionary<String, String> filters = new Dictionary<String, String> ();
		    filters.Add("payer.email", "mail02@mail02.com");
		    filters.Add("begin_date", "2011-01-01T00:00:00Z");
		    filters.Add("end_date", "2011-02-01T00:00:00Z");
      
        // Search payment data according to filters
        Hashtable searchResult = mp.searchPayment (filters);
        
        // Show payment information
        %>
        <table border='1'>
            <tr><th>id</th><th>external_reference</th><th>status</th></tr>
            <%
            foreach (Hashtable payment in searchResult.SelectToken ("response.results")) {
                %>
                <tr>
                    <td><%=payment["id"]%></td>
                    <td><%=payment["external_reference"]%></td>
                    <td><%=payment["status"]%></td>
                </tr>
                <%
            }
            %>
        </table>
    </body>
</html>
