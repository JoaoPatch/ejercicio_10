#!/bin/bash
name: Ejecutar script hola

on:
  push:
 
jobs:
  ejecutar-hola:
	runs_on: ubuntu-latest
	  
	steps:
	  - name: Checkout del repositorio
		 uses: actions/checout@v5
		  
	  - name:Dar permisos de ejecución
		run:chmod +x src/hola.sh
		
	  - name:Ejecutar script
        run: ./src/hola.sh
		