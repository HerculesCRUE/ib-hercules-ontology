prefix asio: <http://purl.org/hercules/asio/core#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix foaf: <http://xmlns.com/foaf/0.1/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# Asio project node.
asio:ProjectShape EXTRA rdf:type {

  # Project type.
  rdf:type [asio:RegionalProject asio:NationalProject asio:EuropeanProject asio:InternationalProject]+ ;

  # Label and comment.
  rdfs:label rdf:langString + ;
  rdfs:comment rdf:langString * ;

  # Project ID.
  asio:projectId xsd:integer ? ;

  # Project acronym.
  asio:projectAcronym xsd:string ? ;

  # Project coordinator/s.
  asio:coordinatedBy @asio:AgentShape * ;

  # Project aim.
  asio:projectObjective rdf:langString ? ;

  # Project keywords.
  asio:projectKeyword rdf:langString * ;

  # Project dates.
  asio:projectEndDate xsd:date ? ;
  asio:projectStartDate xsd:date ;

  # Project foundings.
  asio:isFundedBy @asio:FundingProgrammeShape * ;

  # Project research field.
  asio:hasResearchField @asio:ResearchFieldShape * ;

  # Project outcome.
  asio:projectOutcome . * ;
}

asio:AgentShape {
  a [ foaf:Agent ]
}

asio:FundingProgrammeShape {
}

asio:ResearchFieldShape @asio:ESSubjectAreas3rdListShape OR @asio:ESSubjectAreas2ndListShape OR @asio:ESSubjectAreas1ndListShape

asio:ESSubjectAreas3rdListShape { }
asio:ESSubjectAreas2ndListShape { }
asio:ESSubjectAreas1ndListShape { }
