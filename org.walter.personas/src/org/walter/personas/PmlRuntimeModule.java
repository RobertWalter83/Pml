/*
 * generated by Xtext
 */
package org.walter.personas;

import org.eclipse.xtext.linking.ILinkingDiagnosticMessageProvider;
import org.eclipse.xtext.scoping.IScopeProvider;
import org.eclipse.xtext.scoping.impl.ImportedNamespaceAwareLocalScopeProvider;
import org.walter.personas.scoping.PmlImportScopeProvider;
import org.walter.personas.scoping.PmlScopeProvider;
import org.walter.commons.linking.CustomLinkingDiagnosticMessageProvider; 

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class PmlRuntimeModule extends org.walter.personas.AbstractPmlRuntimeModule {
	
	@Override
	public Class<? extends IScopeProvider> bindIScopeProvider() {
		return PmlScopeProvider.class;
	}
	
	public Class<? extends ImportedNamespaceAwareLocalScopeProvider> bindImportScopeProvider() {
		return PmlImportScopeProvider.class;
	}
	
	public Class<? extends ILinkingDiagnosticMessageProvider> bindILinkingDiagnosticMessageProvider() {
		return CustomLinkingDiagnosticMessageProvider.class; 
	}

}
