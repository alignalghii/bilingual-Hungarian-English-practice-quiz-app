{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.View.Home.DumpView (dumpView) where

import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry (..))
import Prelude hiding (head)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, span, form)
import Control.Monad (forM_)

dumpView :: [LexiconEntry] -> Html
dumpView vocabularyData = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/table.css"
        title "Magyar-angol szó- és mondatgyakorló — Teljes kimutatás"
    body $ do
        h1 "Magyar-angol szó- és mondatgyakorló — Teljes kimutatás"
        p $
            a ! href "/" $ "Vissza a főoldalra"
        table $ do
            tr $ do
                th "Angol"
                th "Magyar"
                th "Szó vagy mondat?"
                th "Nehézségi szint"
            forM_ vocabularyData $ \ LxcE {en, hu, entity, difficulty} -> do
                tr $ do
                    td $ toHtml en
                    td $ toHtml hu
                    td $ toHtml entity
                    td $ toHtml difficulty
