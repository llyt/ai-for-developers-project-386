import "@typespec/http";
import "../models/common.tsp";
import "../models/owner.tsp";
import "../models/event-type.tsp";
import "../models/booking.tsp";

using Http;

namespace BookingApi;

/**
 * Админская часть API. Авторизации нет: все операции неявно выполняются
 * от имени единственного владельца календаря.
 */
@tag("Admin")
@route("/admin")
namespace Admin {
  /** Профиль владельца (только чтение). */
  @summary("Профиль владельца")
  @route("/owner")
  @get
  op getOwner(): Owner;

  /** Управление типами событий (CRUD без удаления — вместо delete архивация). */
  @route("/event-types")
  namespace EventTypes {
    /** Список всех типов событий, включая архивные. */
    @summary("Список типов событий")
    @get
    op list(): EventType[];

    /** Получить тип события по идентификатору. */
    @summary("Получить тип события")
    @route("/{id}")
    @get
    op get(@path id: string): EventType | NotFoundError;

    /** Создать тип события. */
    @summary("Создать тип события")
    @post
    op create(@body body: EventTypeCreate): {
      @statusCode statusCode: 201;
      @body eventType: EventType;
    } | ValidationError;

    /** Частично обновить тип события (в т.ч. архивировать через `active`). */
    @summary("Обновить тип события")
    @route("/{id}")
    @patch
    op update(
      @path id: string,
      @body body: EventTypeUpdate,
    ): EventType | NotFoundError | ValidationError;
  }

  /** Просмотр броней (без создания и отмены через API). */
  @route("/bookings")
  namespace Bookings {
    /** Список броней с фильтрами по диапазону времени и статусу. */
    @summary("Список броней")
    @get
    op list(
      /** Брони, начинающиеся не раньше этого момента (UTC). */
      @query from?: utcDateTime,

      /** Брони, начинающиеся не позже этого момента (UTC). */
      @query to?: utcDateTime,

      /** Фильтр по статусу. */
      @query status?: BookingStatus,
    ): Booking[];

    /** Карточка брони по идентификатору. */
    @summary("Получить бронь")
    @route("/{id}")
    @get
    op get(@path id: string): Booking | NotFoundError;
  }
}
