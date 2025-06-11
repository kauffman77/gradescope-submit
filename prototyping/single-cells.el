;; routines to move single cells around
(add-hook 'org-mode-hook
 '(lambda ()
    ;; Move single table cells
    (local-set-key [C-M-up] (quote org-table-move-single-cell-up))
    (local-set-key [C-M-down] (quote org-table-move-single-cell-down))
    (local-set-key [C-M-left] (quote org-table-move-single-cell-left))
    (local-set-key [C-M-right] (quote org-table-move-single-cell-right))
))

(defun org-table-move-single-cell-up ()
  "Move a single cell up in a table; swap with anything in target cell"
  (interactive)
  (org-table-move-single-cell 'up))

(defun org-table-move-single-cell-down ()
  "Move a single cell down in a table; swap with anything in target cell"
  (interactive)
  (org-table-move-single-cell 'down))

(defun org-table-move-single-cell-left ()
  "Move a single cell left in a table; swap with anything in target cell"
  (interactive)
  (org-table-move-single-cell 'left))

(defun org-table-move-single-cell-right ()
  "Move a single cell right in a table; swap with anything in target cell"
  (interactive)
  (org-table-move-single-cell 'right))
	
(defun org-table-move-single-cell (direction)
  "Move the current cell in a cardinal direction according to the
  parameter symbol: 'up 'down 'left 'right. Swaps contents of
  adjacent cell with current one."
  (unless (org-at-table-p)
    (error "No table at point"))
  (let ((drow 0) (dcol 0))
    (cond ((equal direction 'up)    (setq drow -1))
	  ((equal direction 'down)  (setq drow +1))
	  ((equal direction 'left)  (setq dcol -1))
	  ((equal direction 'right) (setq dcol +1))
	  (t (error "Not a valid direction, must be one of 'up 'down 'left 'right")))
    (let* ((row1 (org-table-current-line))
	   (col1 (org-table-current-column))
	   (row2 (+ row1 drow))
	   (col2 (+ col1 dcol)))
      (unless (< col2 1)                ;Don't move off the left side of the table
        (org-table-swap-cells row1 col1 row2 col2)
        (org-table-goto-line row2)
        (org-table-goto-column col2)))))

(defun org-table-swap-cells (row1 col1 row2 col2)
  "Swap two cells indicated by the coordinates provided"
  (let ((content1 (org-table-get row1 col1))
	(content2 (org-table-get row2 col2)))
    (org-table-put row1 col1 content2)
    (org-table-put row2 col2 content1)
    (org-table-align)))

