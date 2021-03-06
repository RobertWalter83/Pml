/*
 * generated by Xtext
 */
package org.walter.personas.scoping

import org.eclipse.xtext.scoping.IScope
import org.eclipse.emf.ecore.EReference
import org.walter.personas.pml.Persona
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.emf.ecore.EObject
import org.walter.personas.pml.PmlRoot
import org.walter.personas.pml.CustomProperty
import org.walter.personas.pml.CustomAttribute

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 *
 */
class PmlScopeProvider extends org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider {

	def IScope scope_CustomProperty_customAttributeRef(Persona persona, EReference eReference) {

		if (persona.template != null) {
			Scopes.scopeFor(persona.template.customs.map[it.caName])
		} else {
			var EObject root = persona

			do
				root = root.eContainer
			while (root.eContainer != null)

			val characters = root as PmlRoot
			val globals = characters.globals

			if (globals != null) {
				return Scopes.scopeFor(globals.customs.map[it.caName])
			} else
				IScope.NULLSCOPE

		}
	}

	def IScope scope_CustomProperty_enumValue(CustomProperty cp, EReference eReference) {
		Scopes.scopeFor((cp.customAttributeRef.eContainer as CustomAttribute).rgenumValue)
	}
}
