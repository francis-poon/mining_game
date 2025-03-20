class_name Codex
extends Node

signal codex_changed(codex_data: CodexData)

var _save_file_name: String = "codex.tres"

var data: CodexData

func add_codex_entry(entry_id: int):
	if not entry_id in data.unlocked_ids:
		data.unlocked_ids[entry_id] = true
		codex_changed.emit(data)

func add_codex_entries(entry_ids: Array):
	for id in entry_ids:
		add_codex_entry(id)

func save_data(save_dir: String):
	var result = ResourceSaver.save(data, save_dir + _save_file_name)
	if result != OK:
		print(result)

func load_data(save_dir: String):
	data = ResourceLoader.load(save_dir + _save_file_name)
	if not data or data is not CodexData:
		data = CodexData.new({})
	codex_changed.emit(data)
