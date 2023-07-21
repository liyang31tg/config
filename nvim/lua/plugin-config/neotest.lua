local status, neotest = pcall(require, "neotest")
if not status then
	vim.notify("没有找到 neotest")
	return
end

local status1, neotestGo = pcall(require, "neotest-go")
if not status1 then
	vim.notify("没有找到 neotestGo")
	return
end
neotest.setup({
	adapters = {
		neotestGo({
			experimental = {
				test_table = true,
			},
			args = { "-v", "-count=1", "-timeout=60s" },
		}),
	},
})

require("keybindings").mapTEST()

-- Test single function
-- To test a single test hover over the test and run require('neotest').run.run()
--
-- NOTE: Please note that testify test methods cannot be run using this function as go test cannot run these tests individually using the -run flag.
--
-- Test file
-- To test a file run require('neotest').run.run(vim.fn.expand('%'))
--
-- Test directory
-- To test a directory run require('neotest').run.run("path/to/directory")
--
-- Test suite
-- To test the full test suite run require('neotest').run.run("path/to/root_project") e.g. require('neotest').run.run(vim.fn.getcwd()), presuming that vim's directory is the same as the project root
--
-- Additional arguments
-- Additional arguments for the go test command can be sent using the extra_args field e.g.
--
-- require('neotest').run.run({path, extra_args = {"-race"}})
