package org.walter.personas.ui.editor.templates

import com.google.inject.Inject
import org.eclipse.jface.text.templates.ContextTypeRegistry
import org.eclipse.jface.text.templates.TemplateContext
import org.eclipse.jface.text.templates.persistence.TemplateStore
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ui.editor.contentassist.ITemplateAcceptor
import org.eclipse.xtext.ui.editor.templates.ContextTypeIdHelper
import org.eclipse.xtext.ui.editor.templates.DefaultTemplateProposalProvider
import org.eclipse.xtext.ui.editor.templates.XtextTemplateContext
import org.walter.personas.pml.CustomAttribute
import org.walter.personas.pml.PmlPackage
import org.walter.personas.pml.Template
import org.walter.personas.services.PmlGrammarAccess
import org.walter.personas.util.DefaultAttributeHelper
import org.walter.personas.util.U

class PmlTemplateProposalProvider extends DefaultTemplateProposalProvider {
	var helper = null as ContextTypeIdHelper
	var numberTemplateCounter = 0

	@Inject
	PmlGrammarAccess grammarAccess

	@Inject
	new(TemplateStore templateStore, ContextTypeRegistry registry, ContextTypeIdHelper helper) {
		super(templateStore, registry, helper)
		this.helper = helper
	}

	override protected createTemplates(TemplateContext templateContext, ContentAssistContext context,
		ITemplateAcceptor acceptor) {
		super.createTemplates(templateContext, context, acceptor)

		this.numberTemplateCounter = 0
		if (templateContext instanceof XtextTemplateContext) {
			val xTemplateContext = templateContext as XtextTemplateContext
			val id = helper.getId(grammarAccess.personaRule)

			if (xTemplateContext.contextType.id.equals(id)) {
				if (context.currentModel != null) {
					val scopProvider = xTemplateContext.scopeProvider
					val scope = scopProvider.getScope(context.currentModel,
						PmlPackage.Literals.PERSONA__TEMPLATE)
					val templates = newArrayList

					scope.allElements.forEach [
						val resolved = EcoreUtil2.resolve(it.EObjectOrProxy, context.resource.resourceSet)
						if (resolved instanceof Template) {
							val source = resolved as Template
							templates.add(source.createDynamicTemplate)
						}
					]

					templates.forEach [
						val proposal = createProposal(templateContext, context, image, relevance)
						acceptor.accept(proposal)
					]
				}
			}
		}

	}

	def createDynamicTemplate(Template source) {
		new org.eclipse.jface.text.templates.Template(
			"template: " + source.name,
			"insert character template for " + source.name,
			source.name,
			'''
				persona ${name} uses «source.name»
					// default attributes 
					«createDefaultTemplateEntries»
					// template attributes
					«FOR c : source.customs»
						«c.createCustomTemplateEntry»
					«ENDFOR»
				end
				 
				${cursor}
			''',
			true
		)
	}

	def createCustomTemplateEntry(CustomAttribute attribute) {
		var result = ""
		result = result + attribute.caName.name + " "
		result = result + attribute.createCustomValueTemplateExpression + " "
		return result
	}

	def createCustomValueTemplateExpression(CustomAttribute attribute) {
		if (!attribute.rgenumValue.empty) {
			return "(${" + attribute.rgenumValue?.get(0).name + ":Enum('value')})"
		}
		switch (attribute.attributeType.getName()) {
			case "NUMBER": return "${" + (this.numberTemplateCounter = this.numberTemplateCounter + 1) + "}"
			case "TEXT": return "\"${" + attribute.caName.name.replaceAll("\\s+", "") + "Value}\""
		}
	}

	def createDefaultTemplateEntries() {
		val defaults = U.defaultAttributes.values
		var result = ''
		for(v:defaults) {
			result = result + v.name + " "
			result = result + v.createDefaultValueTemplateExpression + "\n"
		}

		result
	}

	def createDefaultValueTemplateExpression(DefaultAttributeHelper helper) {
		switch (helper.type) {
			case "NUMBER":
				return "${" + (this.numberTemplateCounter = this.numberTemplateCounter + 1) + "}"
			case "TEXT":
				return "\"${" + helper.name.replaceAll("\\s+", "") + "Value}\""
			case "ENUM": {
				if (helper.name.equals("sex")) {
					return "${male:Enum('CharaSex')}"
				}
			}
		}
	}

	
}