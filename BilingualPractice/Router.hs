{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.Router where

import BilingualPractice.Controller.HomeController (homeAction, dumpAction, randAction, errorAction)
import BilingualPractice.Controller.PracticeController (proposeExamenAction, performExamenAction, restartPracticeAction, indexPracticeAction, showPracticeAction, closePracticeAction, deletePracticeAction, repeatPracticeAction)
import BilingualPractice.Controller.QuestionController (poseFirstRemainingExamenQuestionOrAnounceResultAction, receiveAnswerForQuestion)
import BilingualPractice.BuiltinServer (builtinServerOptions)
import Web.Scotty (ScottyM, middleware, get, post)


router :: Bool -> ScottyM ()
router logFlag = do
    mapM_ middleware $ builtinServerOptions logFlag
    get  "/"         homeAction
    get  "/dump"     dumpAction
    get  "/rand"     randAction
    get  "/practice/index" indexPracticeAction
    get  "/practice/show/:utc" showPracticeAction
    get  "/practice/new"   proposeExamenAction
    post "/practice/new"   performExamenAction
    post "/practice/restart" restartPracticeAction
    post "/practice/delete" deletePracticeAction
    post "/practice/repeat" repeatPracticeAction
    post "/practice/closefix" closePracticeAction
    get  "/question" poseFirstRemainingExamenQuestionOrAnounceResultAction
    post "/question" receiveAnswerForQuestion

    get  "/error/navigationinconsistency" $ errorAction "Inconsistent traversal of the site: probably You have opened a practice and it got interrupted without closing due to some forced traversal."
    get  "/error/emptydata" $ errorAction "There are no data!"
    --post "/error/closepractice" $ errorClosePracticeAction

-- Important note:
-- entering examenAction reloads the etalon table and empties the personal table,
-- so this should not be a get (a get must lack secondary effects)
-- that is why examen is a post
