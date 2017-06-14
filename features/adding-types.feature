Feature: Adding Types
    Adding new Entity, Resource, Role, and Relation Types to the ontology

    Scenario: Adding a existing Type
        Adding types which already exist in the graph should be prohibited.    
        Given A graph with a Relation Type "my-type"
        When The user adds a new Entity Type "my-type"
        Then The response is an error 

    Scenario: Adding a new Type
        Adding a new type which does not exist in the graph
        Given An empty graph
        When The user adds a new Entity Type
        Then The Type is committed

    Scenario: Adding a new Relation Type
        Adding a new relation type without giving it any roles
        Given An empty graph
        When The user adds a new Relation Type
        And The user adds a new Role Type
        And The user links the Types
        Then The Types are committed

    Scenario: Adding a new Relation Type without Roles
        Adding a new relation type without giving it any roles
        Given An empty graph
        When The user adds a new Relation Type
        Then The response is an error

    Scenario: Adding a new Role Type without a Relation Type
        Adding a new role type without giving it any relation
        Given An empty graph
        When The user adds a new Role Type
        Then The response is an error

    Scenario: Adding a new Type to a new Relation Type
        Adding entity types and allowing them to play roles in relation types
        Given An empty graph
        When The user adds a new Entity Type
        And The user adds a new Relation Type
        And The user adds a new Role Type
        And The user links the Types
        Then The Types are
