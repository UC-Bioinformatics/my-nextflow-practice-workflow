#! /usr/bin/env nextflow

/*
* Using a simple hello world script to understand workflow management in Nextflow
*/

process sayHello {

	input:
	val greeting

	publishDir 'results', mode: 'copy'

	output:
		path "output.txt"
	
	script:
	"""
	echo "$greeting" > output.txt
	"""
	
	
}


/*
* Pipeline parameters
*/
params.greeting = "Hello World"

workflow {	
	
	// execution of above script
	sayHello(params.greeting)

}
