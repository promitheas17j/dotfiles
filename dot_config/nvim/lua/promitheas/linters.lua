vim.cmd('ALEEnable')

vim.g.ale_linters = {
	python = { 'flake8'}
}

vim.g.ale_lint_on_enter = 1
vim.g.ale_lint_on_save = 1
vim.g.ale_echo_cursor = 1
vim.g.ale_echo_msg_error_str = 'E: '
vim.g.ale_echo_msg_warning_str = 'W: '
