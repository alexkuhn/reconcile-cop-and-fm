
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

# Activate Entities

```ruby
wifi.activate
Context.activate({
	:activation   => [europe],
	:deactivation => [usa]})
```

It activates the context *WiFi*, and simultaneously activates the context *Europe* and deactivates the context *USA* (note that in our application, it automatically deactivates *USA* when we activate *Europe*).

# Define Context-Feature Mapping

```ruby
Activatable.add_mapping(
	:enabler,
	map,
	show_map )
Activatable.add_mapping(
	:disabler,
	low_battery,
	show_map )
```

The former adds the context *Map* as **_enabler_** for the feature *showMap*, while the latter adds the context *LowBattery* as **_disable_**r for the feature *showMap*.

# Define Alterations to Existing Features

```ruby 
inform_emergencies.add_alteration(
	:instance_attribute,
	:ERS,
	:emergencies,
	[ Earthquake.new ] )
alert_emergencies.add_alteration(
	:instance_method,
	:ERS,
	:alert,
	lambda do
	    s = “”
	    @emergencies.each do |e|
	        s += “#{e.type} detected nearby\n”
 	    end
	    s
	end )
```

* The former adds an instance attribute *emergencies* to the class *ERS*, containing an array with just an instance of *Earthquake*.
* The latter adds an instance method *alert* to the class *ERS*, which uses the newly added attribute *emergencies* to build a particular message.

# Customize Alteration Composition

```ruby
Alteration.set_custom_order(
	:show_belgian_map,
	:show_european_map )
```

It ensures that alterations from feature *ShowBelgianMap* are applied **_before_** alterations from feature *ShowEuropeanMap* (note: we order alterations by activation age of the features, in addition to refine this order with specified custom orders).

# Footnote

Please look into the folder ```application``` to see exactly how to use the framework for your applications:
* ```application/contexts/InitContexts.rb``` to define contexts;
* ```application/features/InitFeatures.rb``` to define features (and alterations);
* ```application/mapping/InitMapping.rb``` to define mapping between contexts and features;
* ```application/custom_composition/InitCustomComposition.rb``` to set custom orders between features, when composing alterations (it refines sorting by feature’s activation age);
* ```application/classes``` are empty classes that define the skeleton of the application;
* ```main.rb``` gather everything above, and can be executed directly;

