{ ... }: {
  luaToVim = lua: "lua << EOF\n${lua}\nEOF\n";
}