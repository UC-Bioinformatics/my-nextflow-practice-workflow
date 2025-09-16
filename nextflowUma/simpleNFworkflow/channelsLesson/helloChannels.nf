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
// params.greeting = "Hello World!"

workflow {


	greetings_array = ['Hello Channels!', 'Bonjour', 'Hola']
	greeting_ch = Channel.of(greetings_array)	//creation of input channel factory
			     .view {greeting -> "Before flatten: $greeting"} // debug statements to identify if the flatten operator is working as expected
			     .flatten() // addition of flatten operator in order to emit contents of the array in the channel, separately
			     .view {greeting -> "After flatten: $greeting"} // debug statements to identify if the flatten operator is working as expected
	
	// execution of above script
	sayHello(greeting_ch)

}
