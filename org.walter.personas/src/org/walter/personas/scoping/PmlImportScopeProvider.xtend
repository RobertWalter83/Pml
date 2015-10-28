package org.walter.personas.scoping

import org.eclipse.xtext.scoping.impl.ImportedNamespaceAwareLocalScopeProvider
import org.eclipse.xtext.util.Strings

class PmlImportScopeProvider extends ImportedNamespaceAwareLocalScopeProvider {
	
	override protected createImportedNamespaceResolver(String stns, boolean fIgnoreCase) {
		var stnsNew = stns

		if (!Strings.isEmpty(stns))
			stnsNew = stnsNew + ".*"
		super.createImportedNamespaceResolver(stnsNew, fIgnoreCase)
	}
}