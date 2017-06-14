Feature: Adding Types
    Deleting Entity, Resource, Role, and Relation Types from the ontology    

    Scenario: Deleting a Type with instances
        Given A Type with instances
        When The user deletes the Type
        Then The response is an error