Feature: Insert Queries
    The user should be able to perform graql insert queries which write new concepts to the graph.

    Scenario: Insert Types
        Given A random graph with data
        When The user inserts types
        And The types do not exist
        Then Write to the graph
        And Return a response with new concepts

    Scenario: Insert Types Which Exist
        Given A random graph with data
        When The user inserts types
        And The types do exist
        And Return a response with existing concepts

    Scenario: Insert Instances
        Given A random graph with data
        When The user inserts instances
        And The type exits
        Then Write to the graph
        And Return a response with new concepts

    Scenario: Insert Instances With Missing Type
        Given A random graph with data
        When The user inserts an instance
        And The type does not exist
        Then Return an error
