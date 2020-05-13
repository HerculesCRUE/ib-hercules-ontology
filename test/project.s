# Prefixes definitions.
prefix asio: <http://purl.org/hercules/asio/core#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix foaf: <http://xmlns.com/foaf/0.1/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# This shape defines the default schema for a project from the asio ontology. A
# project that follows the ontology should have the following attributes.
#   - projectId -> Any number
#   - projectAcronym -> Optional
#   - coordinatedBy -> Any number
#   - projectObjective -> Optional
#   - projectKeyword -> Any number
#   - projectStartDate -> Exactly one
#   - projectEndDate -> Optional
#   - isFundedBy -> Any number
#   - hasResearchField -> Any number
#   - projectOutcome -> Any number
#
# @author Guillermo Facundo Colunga.
#
# @extra rdf:type indicates that the any node compared against this shape might
#                 have extra rdf:type declarations.
asio:ProjectShape EXTRA rdf:type {

  # Project type.
  # A project might have more than one type from the following.
  #
  # @constraint the type must be must be one of the types in the value set
  # @cardinality indicates that a project might contain one or more declarations
  #              about the type of project.
  rdf:type [asio:RegionalProject asio:NationalProject asio:EuropeanProject asio:InternationalProject] + ;

  # Label and comment.
  # Both label and comment are langStrings as the ontology supports multiple
  # languages. Also it is important to notice that a project must have one or
  # more labels and might have any number of comments.

  # The label of a project represents its title, given that some projects miught
  # have muliple titles the cardinality has been adjusted to suport those with
  # multiples titles.
  #
  # @constraint the label must be a lang string, that means that is a string
  #             tagged with the corresponding language.
  # @cardinality projects might have multiple title/labels and therefore the
  #              cardinality accepts one or more labels.
  rdfs:label rdf:langString + ;

  # The comment of a project represents the description of the project. Again,
  # a project might not contain a description or might contain multiple
  # descriptions.
  #
  # @constraint the description must be a lang string, that means that is a
  #             string tagged with the corresponding language.
  # @cardinality a project might not have or have multiple descriptions, that
  #              implies that the cardinality accepts any number of declarations.
  rdfs:comment rdf:langString * ;

  # If a project contains a project identifier it should be added here the code,
  # sometimes projects might have different project ids so this constraint allows
  # multiple definitions, from 0 to any number.
  #
  # @constraint the project id must be an integer number. (Not really sure about this)
  # @cardinality accepts any number of appearances of the project id.
  asio:projectId xsd:integer * ;

  # The project acronym is an optional string containing the acronym of the project.
  #
  # @constraint the acronym must be of type xsd string.
  # @cardinality this constraint expects the acronym to be optional.
  asio:projectAcronym xsd:string ? ;

  # A project might or might not have any number of coordinators. Each coordinator
  # must conform to the agent shape.
  #
  # @constraint indicates that the agent that cordinates the project must
  #             conform to the shape defined for agent. @ref asio:AgentShape.
  # @cardinality a project might have any number of coordinators.
  asio:coordinatedBy @asio:AgentShape * ;

  # The project aim is a lang string that describes the main aim of the project.
  #
  # @constraint the projecta aim must be an string but language tagged.
  # @cardinality the aim of the project is optional.
  asio:projectObjective rdf:langString ? ;

  # The project project keywords are represented as individual definitions of
  # properties with name projectKeyword. Those definitions must be of type
  # lang string. And a project might have any number of keywords.
  #
  # @constraint a project keyword must be an string but language tagged.
  # @cardinality a project might have any number of keywords.
  asio:projectKeyword rdf:langString * ;

  # The start date of a project is a compulsory field that can appear only once
  # and represents when a project stars.
  #
  # @constraint the date must conform to the xsd:date type.
  # @cardinality the start date must apear once and only once.
  asio:projectStartDate xsd:date ;

  # The end date of a project is a compulsory field that can appear or not and
  # represents when a project ends.
  #
  # @constraint the date must conform to the xsd:date type.
  # @cardinality the end date is optional.
  asio:projectEndDate xsd:date ? ;

  # A project might be founded by founded by any number of founding programmes.
  # Each time a project is founded by a programme appears a declaration that
  # indicates that the project is founded by the founding programme.
  #
  # @constraint the object of the is founded by property must conform to the
  #             founding programme shape. @ref asio:FundingProgrammeShape.
  # @cardinality as a project might be founded by any number of founding
  #              programmes the cardinality allows any number of repetitions.
  asio:isFundedBy @asio:FundingProgrammeShape * ;

  # The project research field indicates area of knowledge of the project.
  # A project might have any number of research fields.
  #
  # @constraint indicates that the research field must conform to the reseach
  #             field shape. @ref asio:ResearchFieldShape
  # @cardinality allows any number of research fields.
  asio:hasResearchField @asio:ResearchFieldShape * ;

  # The project outcome has no specific type but it can appear one or multiple
  # times.
  #
  # @constraint the project outcome might be of any type.
  # @cardinality the project outcome can apear any number of times.
  asio:projectOutcome . * ;
}

# The agent shape encapsulates those nodes that are of type foaf:Agent.
#
# @author Guillermo Facundo Colunga
asio:AgentShape {
  a [ foaf:Agent ]
}

# The founding programme shape will encapsulate the different types of founding
# programmes that might appear.
#
# @author Guillermo Facundo Colunga
asio:FundingProgrammeShape {}

# A reseach field can be one of the different subject areas defining by its level.
#
# @author Guillermo Facundo Colunga
asio:ResearchFieldShape @asio:ESSubjectAreas3rdListShape
                        OR @asio:ESSubjectAreas2ndListShape
                        OR @asio:ESSubjectAreas1ndListShape

# Auxiliary shapes
asio:ESSubjectAreas3rdListShape { }
asio:ESSubjectAreas2ndListShape { }
asio:ESSubjectAreas1ndListShape { }
