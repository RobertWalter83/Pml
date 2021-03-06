/*
 * generated by Xtext
 */
package org.walter.personas.formatting

import org.eclipse.xtext.formatting.impl.AbstractDeclarativeFormatter
import org.eclipse.xtext.formatting.impl.FormattingConfig
import com.google.inject.Inject;
import org.walter.personas.services.PmlGrammarAccess
import org.eclipse.xtext.Keyword
import org.eclipse.xtext.AbstractElement

/**
 * This class contains custom formatting declarations.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#formatting
 * on how and when to use it.
 * 
 * Also see {@link org.eclipse.xtext.xtext.XtextFormattingTokenSerializer} as an example
 */
class PmlFormatter extends AbstractDeclarativeFormatter {

	@Inject extension PmlGrammarAccess

	override protected void configureFormatting(FormattingConfig c) {
		c.setLinewrap(0, 1, 2).before(SL_COMMENTRule)
		c.setLinewrap(0, 1, 2).before(ML_COMMENTRule)
		c.setLinewrap(0, 1, 1).after(ML_COMMENTRule)

		c.setLinewrap.after(pmlRootAccess.rgimportAssignment_0)
		c.setLinewrap.after(pmlRootAccess.rgimportImportParserRuleCall_0_0)

		// template block
		c.setDefaultBlockLayout(templateAccess.templateKeyword_0, templateAccess.nameAssignment_1,
			templateAccess.endKeyword_5, templateAccess.endKeyword_5, templateAccess.defaultsAssignment_2,
			templateAccess.customsAssignment_3, templateAccess.customsAssignment_4)

		// customs block
		c.setDefaultBlockLayout(globalsAccess.globalKeyword_0, globalsAccess.attributesKeyword_1,
			globalsAccess.endKeyword_4, globalsAccess.endKeyword_4, globalsAccess.customsAssignment_2,
			globalsAccess.customsAssignment_3)

		// character block
		c.setDefaultBlockLayout(personaAccess.personaKeyword_0, personaAccess.nameAssignment_1,
			personaAccess.endKeyword_4, personaAccess.endKeyword_4, personaAccess.rgpropertyAssignment_3)

	}

	def void setDefaultBlockLayout(FormattingConfig c, Keyword start, AbstractElement indentStart,
		AbstractElement indentEnd, Keyword end, AbstractElement... content) {
		c.setLinewrap(2).before(start)
		c.setIndentation(indentStart, indentEnd)
		content.forEach[
			c.setLinewrap.before(it)
		]
		c.setLinewrap.before(end)
	}
}
