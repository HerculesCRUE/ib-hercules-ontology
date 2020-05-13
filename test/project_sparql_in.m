SPARQL """
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix asio: <http://purl.org/hercules/asio/core#>
select ?v where {
 ?v rdf:type asio:EuropeanProject
}"""@asio:ProjectShape
