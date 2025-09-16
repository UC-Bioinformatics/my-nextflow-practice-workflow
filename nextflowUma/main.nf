#! /usr/bin/env nextflow

process runBlast {

  
  script:
  """
  blastn -num_threads $params.threads -db $params.dbDir/$params.dbName -query $params.query -outfmt 6 -out $params.outfileName
  """

}


workflow {

	runBlast()
}
