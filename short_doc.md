
# Create and Get Contexts and Features

```ruby
emergency = Context.new(:emergency)
show_map  = Feature.new(:show_map)
location  = Context.get(:location)
```

Creates the context *Emergency* and the feature *showMap*.

# Define Relations Between Entities

```ruby
Context.add_configuration_relation(
	:optional,
	Context.default,
	emergency )
Context.add_configuration_relation(
	:alternative,
	battery,
	low_battery,
	high_battery )
Context.add_configuration_relation(
	:additional,
	[  :implication
	   map,
	   [   :conjunction,
	       location,
  	       connectivity ] ] )
Context.add_dependency_relation(
	:causality,
	Context.default,
	usa )
```

 * Adds an **_optional_** parent-child relation between contexts *Default* and *Emergency*;
* Adds an **_alternative_** relation between contexts *LowBattery* and *HighBattery*, where *Battery* is parent of the former ones;
* Adds the following **_additional_** constraint: *Map* **implies** **(** *Location* **and** *Connectivity* **)**;
* Adds a **_causality_** relation between the contexts *Default* and *USA*, from *Default* to *USA*.

