
# Structure

* ```application/contexts/InitContexts.rb``` to define contexts;
* ```application/features/InitFeatures.rb``` to define features (and alterations);
* ```application/mapping/InitMapping.rb``` to define mapping between contexts and features;
* ```application/custom_composition/InitCustomComposition.rb``` to set custom orders between features, when composing alterations (it refines sorting by feature’s activation age);
* ```application/classes``` are empty classes that define the skeleton of the application;
* ```main.rb``` gathers everything above, and can be executed directly;

# Scenario

By default, the application set the location to *USA*. It displays some general informations, such as providing the emergency call. There’s also a map that is centered on USA, which shows the position of the user on it.

## Step 1

The device detect that we are in *Belgium*, so it activates the corresponding context. It updates the map and the emergency call (from USA’s 911 to Europe’s 112).

[Screenshot of Step 1](screenshots/step1.png)

## Step 2

An earthquake has been detected nearby, and the device detects that we are inside the dangerous zone of the earthquake. Therefore, it guides us out of the dangerous zone, which is displayed on the visually map and textually below the map.

[Screenshot of Step 2](screenshots/step2.png)

## Step 3

A wildfire has been detected nearby, and we have manually activated a feature to have information on nearby safe places. The safe places and the wildfire are shown on the map visually, and below the map textually. The guidance route has been changed due to the wildfire and the knowledge of safe places: we do not simply move away from the dangerous zone, but we also move to the nearest safe place (while avoiding any danger on our path, hence UZLeuven is shorted than UCL).

[Screenshot of Step 3](screenshots/step3.png)

## Step 4

The device detects that the battery power is low, so it activates the corresponding context. We manually deactivates the guidance feature, so that we reduce even more the battery consumption. The application does neither show the map, nor provide textual guidance.

[Screenshot of Step 4](screenshots/step4.png)


# How to run

Use the following command at the current directory, to run the ERS application:

```
$ ruby main.rb
```

# Documentation of the framework

[Link to the README.md of the framework.](../framework/README.md)