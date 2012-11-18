;;;;;;;;; emacs.el ;;;;;;;;;
;; last update 2012.08.27 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs 23より前のバージョンを利用している場合
;; user-emacs-directory変数が未定義のため次の設定を追加
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list `load-path default-directory)
	(if (fboundp `normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;; 言語を日本語にする
(set-language-environment "Japanese")

(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; windowのサイズを設定
(setq initial-frame-alist
      (append (list
	       '(width . 90)
	       '(height . 47)
	       '(top . 0)
	       '(left . 0)
	       )
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;; Color
(if window-system (progn
  ;; 背景色
  (add-to-list 'default-frame-alist '(background-color . "black"))
  ;; 文字色
  (add-to-list 'default-frame-alist '(foreground-color . "azure3"))
  ;; カーソル色
  (add-to-list 'default-frame-alist '(cursor-color . "white"))
  ;; マウス色
  (add-to-list 'default-frame-alist '(mouse-color . "white"))
  (add-to-list 'default-frame-alist '(border-color . "black"))
))

;; フォントの設定
(set-face-attribute 'default nil
                    :family "monaco" ;;英語
                    :height 120)
(set-fontset-font 
 (frame-parameter nil 'font) 
 'japanese-jisx0208
 '("Hiragino Maru Gothic Pro" . "iso10646-1")) ;;日本語

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f -Emacs@%s" (system-name)))

;; 選択領域の色
(add-to-list 'default-frame-alist '(face-background 'region . "#555"))

;; ビープ音の消去
(setq ring-bell-function 'ignore)

;; 対応する括弧を光らせる
(show-paren-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; キーバインドの設定
;; C-mにnewline-and-indentを割り当てる
(define-key global-map (kbd "C-m") `newline-and-indent)

;; "C-t"でウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") `other-window)

;;;;; YaTex ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Settings for YaTex ;;
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq load-path(cons(expand-file-name "~/.emacs.d/site-lisp/yatex")load-path))

;; Settings for platex command ;;
(setq tex-command "platex --kanji=sjis")
;(setq tex-command "platex --kanji=euc --fmt=platex-euc")


;; Settings for Previwer Mxdvi ;;
(setq dvi2-command "open -a Mxdvi")

;prefixを変える
(setq YaTeX-prefix "\C-c")

;AMS-Latexを使用する
(setq YaTex-use-AMS-LaTex t)

;YaTeXでコメントアウト、解除を割り当てる
(add-hook 'yatex-mode-hook
	  '(lambda ()
	     (local-set-key "\C-c\C-c" 'comment-region)
	     (local-set-key "\C-c\C-u" 'uncomment-region) ))

;; 文章作成時の漢字コードの設定
;; 1 = Shift_JIS, 2 = ISO-2022-JP, 3 = EUC-JP
;; default は 2
(setq YaTeX-kanji-code 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
