---
title: Glossary
weight: 20000
pre: "<i class=\"fas fa-book\" aria-hidden=\"true\"></i> "
---

Flogo terminology and constructs, defined here, all in one place in a logical order vs alphabetical.

## App

An application in Flogo terms is comprised of one or more triggers and flows (actions). The application itself is really just an organizational mechanism that can be leveraged when developing microservices & functions. An application contains a set of configurations, as well as triggers and a collection of flows.

## Trigger

Flogo is an event-driven framework. A trigger is the entrypoint for events. A trigger can be a subscriber on an MQTT topic, Kafka topic, HTTP REST interface or a specific IoT sensor. The trigger is responsible for accepting the incoming event and invoking one or more defined actions (flows).

Triggers are not coupled to flows, that is, a flow can exist without a trigger.

## Handlers

The trigger handler is used to map triggers to actions (flows) for processing. A trigger can have one or more handlers that can route events to different flows.

## Action

As stated in the triggers section above, Flogo is an event-driven framework. Incoming events can be mapped to an action. An action is a generic implementation for processing the incoming event. Different types of actions can be implemented, thus defining different methods by which an incoming event can be processed.

Today, only a single action type has been implemented - the Flow.

## Flow

A flow is an implementation of an action and is the primary tool to implement business logic in Flogo. A flow can consist of a number of different constructs:

- One or more activities that implement specific logic (for example write to a database, invoke a REST endpoint, etc)
- Each activity is connected via a link
- Links can contain conditional logic to alter the path of a flow

Flows, as previously stated in the triggers section, can exist without a trigger. Thus, flows operate very similar to functions, that is, a single flow can define its own input & output parameters. Thus, enabling a flow to be reused regardless of the trigger entrypoint. All logic in the flow only operates against the following data:

- Flow input parameters
- Environment variables
- Application properties
- The output data from activities referenced in the flow

The flow cannot access trigger data directly, trigger input and output data must be mapped into the flows input and output parameters. Refer to [Development > Flows > Mappings](../development/flows/mapping/)

## Mapping

The phrase mapping occurs quite often and refers to the concept of taking properties from one object and associating them with properties of another object. For example, consider object A exposes two properties and activity B accepts only a single input parameter, the two properties need to be concatenated (for example) and 'mapped' into the single input of activity B.

## Activity

An activity is the unit of work that can be leveraged within a Flow. An activity can be any number of things and can be compared to a simple function in Go or any other procedural language, that is, an activity accepts input params and will return one or more objects on return, both input & output params are defined by the activity metadata.