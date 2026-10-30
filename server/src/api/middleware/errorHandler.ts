import type { Request, Response, NextFunction } from "express";
import { AppError } from "../../shared/errors/AppError.ts";

export const errorHandler = (
    err: unknown,
    req: Request,
    res: Response,
    next: NextFunction
) => {
    
    if (res.headersSent) {
        return next(err);
    }

    const isDev = process.env.NODE_ENV !== "production";

    if (err instanceof AppError) {
        return res.status(err.statusCode).json({
            success: false,
            message: err.message,
            ...(err.details !== undefined ? { details: err.details } : {}),
            ...(isDev ? { stack: err.stack } : {})
        });
    }

    if (
        err instanceof SyntaxError &&
        "status" in err &&
        (err as { status?: number }).status === 400
    ) {
        return res.status(400).json({
            success: false,
            message: "Invalid JSON format in request body"
        });
    }

    if (typeof err === "object" && err !== null && "code" in err) {
        const pgError = err as { code: string; detail?: string };

        switch (pgError.code) {
            case "23505": // Unique constraint violation
                return res.status(409).json({
                    success: false,
                    message: "A record with this value already exists",
                    ...(isDev && pgError.detail ? { details: pgError.detail } : {})
                });

            case "23503": // Foreign key constraint violation
                return res.status(400).json({
                    success: false,
                    message: "Referenced resource does not exist",
                    ...(isDev && pgError.detail ? { details: pgError.detail } : {})
                });

            case "22P02": // Invalid input syntax (e.g. invalid UUID / integer)
                return res.status(400).json({
                    success: false,
                    message: "Invalid input syntax for database field",
                    ...(isDev && pgError.detail ? { details: pgError.detail } : {})
                });
        }
    }

    console.error("Unhandled request error:", err);

    return res.status(500).json({
        success: false,
        message: "Internal server error",
        ...(isDev
            ? {
                  error: err instanceof Error ? err.message : String(err),
                  stack: err instanceof Error ? err.stack : undefined
              }
            : {})
    });
};
