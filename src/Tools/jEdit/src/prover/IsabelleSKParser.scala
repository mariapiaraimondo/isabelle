/*
 * SideKick parser for Isabelle proof documents
 *
 * @author Fabian Immler, TU Munich
 * @author Makarius
 *
 * TODO:
 *   - locking of buffer and/or document model (!?)
 *   - check treatment of assets
 *   - completion support
 *   - rename to isabelle.jedit.IsabelleSideKickParser
 */

package isabelle.prover


import javax.swing.tree.DefaultMutableTreeNode

import isabelle.jedit.Plugin

import org.gjt.sp.jedit.{Buffer, EditPane}
import errorlist.DefaultErrorSource
import sidekick.{SideKickParser, SideKickParsedData, SideKickCompletion}


class IsabelleSKParser extends SideKickParser("isabelle") {

  /* parsing */

  private var stopped = false
  override def stop () = { stopped = true }

  def parse(buffer : Buffer, error_source : DefaultErrorSource): SideKickParsedData = {
    stopped = false
    
    val data = new SideKickParsedData(buffer.getName)
    
    Plugin.plugin.prover_setup(buffer) match {
      case None =>
        data.root.add(new DefaultMutableTreeNode("<buffer inactive>"))
      case Some(prover_setup) =>
        val document = prover_setup.prover.document
        val commands = document.commands()
        while (!stopped && commands.hasNext) {
          data.root.add(commands.next.root_node.swing_node)
        }
        if (stopped) data.root.add(new DefaultMutableTreeNode("<parser stopped>"))
      }

    data
  }


  /* completion */

  override def supportsCompletion = true
  override def canCompleteAnywhere = true

  override def complete(pane: EditPane, caret: Int): SideKickCompletion = null
}
