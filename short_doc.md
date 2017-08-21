
# Create and Get Contexts and Features

	emergency = Context.new(:emergency)
	show_map  = Feature.new(:show_map)
	location  = Context.get(:location)

Creates the context Emergency and the feature showMap.

# Define Relations Between Entities

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

 * Adds an optional parent-child relation between context Default and the context Emergency;
* Adds an alternative relation between LowBattery and HighBattery, where Battery is the parent of the former contexts;
* Adds the following additional constraint: Map implies (Location and Connectivity);
* Adds a causality relation between the contexts Default and USA, from Default and USA.

