#! /usr/bin/env nextflow

/*
* Using a simple hello world script to understand workflow management in Nextflow
*/

process sayHello {

	input:
	val greeting

	publishDir 'results', mode: 'copy'

	output:
		path "$greeting-output.txt"
	
	script:
	"""
	echo "$greeting" > '$greeting-output.txt'
	"""
	
	
}


/*
* Pipeline parameters
*/
params.greeting = 'greetings.csv'

workflow {
	
	// create a channel to take input from a csv file
	greeting_ch = Channel.fromPath(params.greeting)	//creation of input channel factory
			     .view { csv -> "Before splitCsv: $csv"}
			     .splitCsv()
			     .view { csv -> "After splitCsv: $csv"}
			     .map {item -> item[0]}
			     .view { csv -> "After map: $csv"}
	// execution of above script
	sayHello(greeting_ch)

}
