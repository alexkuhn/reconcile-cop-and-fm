
# Structure

* ```application/contexts/InitContexts.rb``` to define contexts;
* ```application/features/InitFeatures.rb``` to define features (and alterations);
* ```application/mapping/InitMapping.rb``` to define mapping between contexts and features;
* ```application/custom_composition/InitCustomComposition.rb``` to set custom orders between features, when composing alterations (it refines sorting by feature’s activation age);
* ```application/classes``` are empty classes that define the skeleton of the application;
* ```main.rb``` gather everything above, and can be executed directly;