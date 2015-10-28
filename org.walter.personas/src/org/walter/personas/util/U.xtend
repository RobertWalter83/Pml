package org.walter.personas.util

import org.eclipse.emf.ecore.EClass
import org.walter.personas.pml.PmlPackage
import org.eclipse.xtend.lib.annotations.Accessors

class U {
	
	static val defaults = <String, DefaultAttributeHelper>newHashMap
	static val defaults2 = <EClass, String>newHashMap	
	
	static public def getDefaultAttributes() {
		if(defaults.empty) {
			defaults.put('full name', new DefaultAttributeHelper('full name', 'TEXT', PmlPackage.Literals.FULL_NAME))
			defaults.put('age', new DefaultAttributeHelper('age', 'NUMBER', PmlPackage.Literals.AGE))
			defaults.put('sex', new DefaultAttributeHelper('sex', 'ENUM', PmlPackage.Literals.SEX))
			defaults.put('description', new DefaultAttributeHelper('description', 'TEXT', PmlPackage.Literals.DESCRIPTION))
		}
		defaults	
	}
	
	static private def getDefaultAttributes2() {
		if(defaults2.empty) {
			defaults2.put(PmlPackage.Literals.FULL_NAME, 'full name')
			defaults2.put(PmlPackage.Literals.AGE, 'age')
			defaults2.put(PmlPackage.Literals.SEX, 'sex')
			defaults2.put(PmlPackage.Literals.DESCRIPTION, 'description')
		}
		defaults2	
	}	
	
	static def getEClassFor(String key) {
		getDefaultAttributes.get(key).EClass
	}	
	
	
	static def getKeywordValueFor(EClass key) {
		getDefaultAttributes2.get(key)
	}	
}

class DefaultAttributeHelper {
	@Accessors String name
	@Accessors String type
	@Accessors EClass eClass
	
	new(String name, String type, EClass eClass) {
		this.name = name
		this.type = type
		this.EClass = eClass
	}
}