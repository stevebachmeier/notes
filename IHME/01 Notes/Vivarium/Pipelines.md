- Builder.value.register_value_producer is the function that makes the pioeline
    - Name: pipeline name
    - Source: The function that returns the thing you're getting (eg exposure)
    - Requires_columns: It's kind of what the pipeline value of interest (eg ldlc exposure) is stratified by eg `["age", "sex"]`
    - Requires_values: Any required pipelines (eg [self.propensity_pipeline_name])
    - Preferred_postprocessor: any extra postprocessors, eg get_exposure_post_processor which looks for bins to label a continouous exposure into)
    - Preferred_combiner: 

#vivarium #pipeline