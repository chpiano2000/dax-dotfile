vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all" })
keymap.set("n", "te", ":tabedit<Return>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Java
function GenerateJavaGetterSetter()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local methods = {}

  for _, line in ipairs(lines) do
    local type, var_name = line:match("private%s+([%w<>%[%]]+)%s+(%w+);")
    if type and var_name then
      local method_name = var_name:gsub("^%l", string.upper) -- Capitalize first letter

      -- Generate getter and setter as separate lines
      table.insert(methods, "public " .. type .. " get" .. method_name .. "() {")
      table.insert(methods, "    return " .. var_name .. ";")
      table.insert(methods, "}")
      table.insert(methods, "") -- Add a blank line for readability

      table.insert(methods, "public void set" .. method_name .. "(" .. type .. " " .. var_name .. ") {")
      table.insert(methods, "    this." .. var_name .. " = " .. var_name .. ";")
      table.insert(methods, "}")
      table.insert(methods, "") -- Add another blank line

      table.insert(methods, "public void display" .. method_name .. "(" .. type .. " " .. var_name .. ") {")
      table.insert(methods, "    System.out.println(" .. var_name .. ");")
      table.insert(methods, "}")
      table.insert(methods, "") -- Add another blank line
    end
  end

  if #methods > 0 then
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, methods) -- Append at the end of the file
    print("Generated getters and setters successfully!")
  else
    print("No private fields found!")
  end
end

keymap.set("n", "<leader>gs", ":lua GenerateJavaGetterSetter()<CR>", { noremap = true, silent = true })

function FormatJavaClass()
  local start_time = os.clock()

  -- Read buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fields, constructors, methods = {}, {}, {}

  local current_section = "other"
  local method_pattern = "^%s*public%s+.*%s+(%w+)%s*%((.-)%)"
  local constructor_pattern = "^%s*public%s+(%w+)%s*%((.-)%)"
  local field_pattern = "^%s*(private|protected|public)%s+[%w<>%[%]]+%s+(%w+)%s*;"

  local function count_params(params)
    if params == "" then
      return 0
    end
    return select(2, params:gsub(",", "")) + 1
  end

  local buffer = {}
  local function store_current()
    if #buffer > 0 then
      local text = table.concat(buffer, "\n")
      if current_section == "fields" then
        table.insert(fields, text)
      elseif current_section == "constructors" then
        table.insert(constructors, text)
      else
        table.insert(methods, text)
      end
      buffer = {}
    end
  end

  for _, line in ipairs(lines) do
    local method_name, params = line:match(method_pattern)
    local constructor_name, constructor_params = line:match(constructor_pattern)
    local field_name = line:match(field_pattern)

    if field_name then
      store_current()
      current_section = "fields"
    elseif constructor_name then
      store_current()
      current_section = "constructors"
    elseif method_name then
      store_current()
      current_section = "methods"
    end
    table.insert(buffer, line)
  end
  store_current()

  -- Remove duplicate fields and methods
  local function remove_duplicates(section)
    local seen = {}
    local unique = {}
    for _, item in ipairs(section) do
      if not seen[item] then
        table.insert(unique, item)
        seen[item] = true
      end
    end
    return unique
  end

  fields = remove_duplicates(fields)
  constructors = remove_duplicates(constructors)
  methods = remove_duplicates(methods)

  -- Sort parameterized constructors by argument count
  table.sort(constructors, function(a, b)
    local _, params_a = a:match(constructor_pattern)
    local _, params_b = b:match(constructor_pattern)
    return count_params(params_a) < count_params(params_b)
  end)

  -- Sort methods alphabetically
  table.sort(methods, function(a, b)
    local name_a = a:match(method_pattern) or ""
    local name_b = b:match(method_pattern) or ""
    return name_a < name_b
  end)

  -- Construct formatted output
  local formatted_lines = {}

  local function append_section(section)
    for i, part in ipairs(section) do
      if i > 1 then
        table.insert(formatted_lines, "")
      end
      for line in part:gmatch("[^\r\n]+") do
        table.insert(formatted_lines, line)
      end
    end
  end

  append_section(fields)
  if #fields > 0 and #constructors > 0 then
    table.insert(formatted_lines, "")
  end
  append_section(constructors)
  if (#constructors > 0 or #fields > 0) and #methods > 0 then
    table.insert(formatted_lines, "")
  end
  append_section(methods)

  -- Replace buffer content with formatted lines
  vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)

  local elapsed_time = os.clock() - start_time
  print(string.format("Java code formatted in %.2f seconds", elapsed_time))
end

keymap.set("n", "<leader>sa", ":lua FormatJavaClass()<CR>", { noremap = true, silent = true })
