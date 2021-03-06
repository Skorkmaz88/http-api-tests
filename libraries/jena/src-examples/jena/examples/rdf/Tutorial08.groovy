/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package jena.examples.rdf ;

System.setProperty 'javax.xml.parsers.DocumentBuilderFactory', 'com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl'

import com.hp.hpl.jena.rdf.model.*;
import com.hp.hpl.jena.util.FileManager;
import com.hp.hpl.jena.vocabulary.*;

import java.io.*;


/** Tutorial 8 - demonstrate Selector methods
 */
    
    final String inputFileName = "vc-db-1.rdf";
    
        // create an empty model
        Model model = ModelFactory.createDefaultModel();
       
        // use the FileManager to find the input file
        InputStream input = FileManager.get().open(inputFileName);
        if (input == null) {
            throw new IllegalArgumentException( "File: " + inputFileName + " not found");
        }
        
        // read the RDF/XML file
        model.read( input, "" );
        
        // select all the resources with a VCARD.FN property
        // whose value ends with "Smith"
        StmtIterator iter = model.listStatements(
            new 
                SimpleSelector(null, VCARD.FN, (RDFNode) null) {
                    @Override
                    public boolean selects(Statement s) {
                            return s.getString().endsWith("Smith");
                    }
                });
        if (iter.hasNext()) {
            System.out.println("The database contains vcards for:");
            while (iter.hasNext()) {
                System.out.println("  " + iter.nextStatement()
                                              .getString());
            }
        } else {
            System.out.println("No Smith's were found in the database");
        }
